---
layout: blog
category: LLM
title:  使用langchain框架调用豆包/火山实现 RAG
date:   2025-06-29 18:32:34
background-image: http://ot1cc1u9t.bkt.clouddn.com/17-8-1/24280498.jpg
tags:
- langchain
- openai
- llm
---



> 本文使用豆包（火山云）的 api 实现了 rag 技术，难点主要有以下几点
>
> - 首先是豆包（很多大国产模型）的api不支持 `langchain_openai`，只支持`openai`
> - 其次，`langchain`本身没有`Embeddings`模型，没有办法直接使用。
>
> 通过阅读本文，可以获得：
>
> -  该问题的原因
> - `langchain`和 `openai `模块的区别



### RAG介绍

RAG（Retrieval-Augmented Generation，检索增强生成）

- 能够根据用户输入的问题,动态从知识库中检索出最【相关的文档片段或知识条目】,并将其作为【上下文】输入到生成模型中。



要实现rag，就首先能够调用`embeddings`（无论是使用本地还是云服务），但是没有厂家适配`langchain_openai`

### embeddings问题



#### 问题查找

```python
# 错误代码如下：
from langchain_openai import OpenAIEmbeddings
import os

# 1. 使用 LangChain 内置的 OpenAI 兼容方案
embeddings = OpenAIEmbeddings(
    model="doubao-embedding-text-240715",       # 火山模型名称
    openai_api_key=<api_key>,# 火山API Key
    openai_api_base="https://ark.cn-beijing.volces.com/api/v3"  # 火山API端点
)

# 生成嵌入向量
input_texts = [
    "Hi there!",
    "Oh, hello!",
    "What's your name?",
    "My friends call me World",
    "Hello World!"
]
result = embeddings.embed_documents(input_texts)
    #################################################
python中错误代码如下：
Traceback (most recent call last):
  File  in 
    result = embeddings.embed_documents(input_texts)
  File "\site-packages\langchain_openai\embeddings\base.py", line 590, in embed_documents
    return self._get_len_safe_embeddings(
  File "\site-packages\langchain_openai\embeddings\base.py", line 478, in _get_len_safe_embeddings
    response = self.client.create(
  File "site-packages\openai\resources\embeddings.py", line 129, in create      
    return self._post(
  File "\site-packages\openai\_base_client.py", line 1249, in post
    return cast(ResponseT, self.request(cast_to, opts, stream=stream, stream_cls=stream_cls))
  File "site-packages\openai\_base_client.py", line 1037, in request
    raise self._make_status_error_from_response(err.response) from None
openai.BadRequestError: Error code: 400 - {'error': {'code': 'InvalidParameter', 'message': 'The parameter `input[0]` specified in the request are not valid: expected a string, but got `[45951 109 162 97 108 86894 250 5877 230 25666 86894 250 45951 109 5486 45951 109 86894 250 3922 21043 15120 87502 40053 90070 9554 164 242 105 86894 250 1811]` instead. Request id: ', 'param': 'input[0]', 'type': 'BadRequest'}}
        
```



​	同样的代码，来使用`openai`库实现就没有问题

```python
# 能够运行
import os
from openai import OpenAI

# gets API Key from environment variable OPENAI_API_KEY
client = OpenAI(
    api_key=<api_key>,
    base_url="https://ark.cn-beijing.volces.com/api/v3",
)

print("----- embeddings request -----")
resp = client.embeddings.create(
    model="doubao-embedding-text-240715",
    input=["花椰菜又称菜花、花菜，是一种常见的蔬菜。"],
    encoding_format="float"
)
print(resp)

```





#### 问题原因

| 特性             | openai 库 (Python)                      | langchain-openai                                |
| :--------------- | :-------------------------------------- | :---------------------------------------------- |
| **提供方**       | **OpenAI 官方**                         | **LangChain 开源项目**                          |
| **性质**         | 官方 SDK，提供对 API 的底层直接访问     | LangChain 框架的一个集成包（依赖 `openai` 库）  |
| **目的**         | 直接、灵活地与 OpenAI API 交互          | 让 OpenAI 模型能在 LangChain 框架中作为组件使用 |
| **维护方**       | OpenAI                                  | LangChain 社区                                  |
| **官方支持范围** | OpenAI 直接为此 SDK 和 API 行为提供支持 | OpenAI **不直接负责**支持 LangChain 的集成封装  |
| **抽象层级**     | 低层级/类HTTP (接近 HTTP API)           | 高层级 (遵循 LangChain 组件接口)                |





**`langchain-openai` 这个包本质上就是用来调用 OpenAI 的官方 API 的**。所以从底层通信的角度看，你完全正确。

支持 `openai` 库但不“官方支持” `langchain-openai` 听起来有点矛盾，但原因在于**抽象层级、开发维护责任和生态系统定位**的不同。让我详细解释一下：

1. 抽象层级与复杂性：
   - **`openai` 库 (Python)：** 这是 OpenAI 官方发布和维护的 SDK。它提供对 OpenAI API（包括 ChatGPT, GPT-4, DALL·E, Whisper, Embeddings 等）最直接、最低层级的访问。你需要自己处理 API 密钥、构建请求、解析响应、管理异步调用、处理错误重试等。
   - **`langchain-openai` (LangChain 的一部分)：** 这是 LangChain 框架的一个集成包。LangChain 是一个**构建在 LLM 之上**的框架，专注于**链式调用**（Chains）、**智能体**（Agents）、**记忆**（Memory）、**文档处理**等**高层次应用结构**。`langchain-openai` 将 OpenAI 的官方 API 封装成了 LangChain 框架中的“组件”（如 `ChatOpenAI`, `OpenAIEmbeddings`）。它内部使用的是 `openai` 库，但它添加了 LangChain 框架所需的接口、统一参数名、可能的默认设置和集成到 LangChain 生态的逻辑。你通过 LangChain 的接口调用 OpenAI。
2. 开发与维护责任：
   - **`openai` 库：** 由 OpenAI 官方团队完全负责开发、测试、发布新版本、修复 bug 以及与 API 变更保持同步。OpenAI 对其稳定性和功能负责。
   - `langchain-openai`： 是 LangChain 开源项目的一部分，主要由 LangChain 社区（核心贡献者和社区开发者）维护。虽然它的功能高度依赖于`openai`库，但 LangChain 的团队需要：
     - 将 `openai` 库的更新适配到 LangChain 的抽象层中。
     - 确保其封装的组件符合 LangChain 的设计模式和要求。
     - 处理 LangChain 特有的参数或行为（比如流式输出的特殊处理、在 Agents/Chains 中的交互方式）。
     - 可能添加一些 LangChain 视角的便利功能或补丁（尽管尽量保持精简）。它的更新节奏可能与官方的 `openai` 库略有不同。
3. OpenAI 的视角和支持范围：
   - OpenAI 作为模型提供方和 API 提供方，其核心职责是确保 **API 本身** 和 **官方 SDK (`openai` 库)** 的稳定性和可用性。他们为这些提供直接的**官方支持**。
   - OpenAI **不拥有、不直接控制、也不官方维护 LangChain 或 `langchain-openai`**。LangChain 是一个独立的框架，它选择集成 OpenAI（也集成 Anthropic, Cohere, Hugging Face 等许多其他模型服务）。
   - 因此，当你遇到与`langchain-openai`相关的问题时：
     - 问题可能出在 LangChain 的封装逻辑上（参数映射错误、接口变化、框架集成bug）。
     - 问题也可能出在底层的 `openai` 库或 API 本身。
     - **OpenAI 官方支持团队**通常只负责排查 `openai` 库本身的问题以及 API 后端的问题。如果问题被定位为是 LangChain 封装层的问题，他们**无法**直接修复 `langchain-openai` 的代码，只能建议用户去 LangChain 社区（如 GitHub issues, Discord）寻求帮助，或者尝试使用官方的 `openai` 库复现问题。
4. 生态定位：
   - **OpenAI**： 提供模型和访问模型的基础设施（API 和 SDK）。
   - **LangChain**： 提供一个构建在 LLM API 之上的应用开发框架。`langchain-openai` 是让 **OpenAI 的模型能够在 LangChain 框架中被使用**的**适配器**或**集成插件**。



#### 解决尝试

```python
from langchain_community.embeddings import HuggingFaceEmbeddings

model_name = "doubao-embedding-text-240715" # 或你使用的模型名称
endpoint_url = "https://ark.cn-beijing.volces.com/api/v3/embeddings"  # 火山 Embedding 地址

# 无法认证
embeddings = HuggingFaceEmbeddings(
    model_name=model_name,
    endpoint_url=endpoint_url,
    encode_kwargs={"normalize_embeddings": True},  # 可选标准化
    headers={"Authorization": f"Bearer {api_key}"}
)
```









#### 解决方案

​	因为`deepseek`只提供了模型服务，我们没有国外信用卡，没办法进行`openai-api`的调用，只能使用国产平台或者本地部署的模型来实现，因为本机环境资源有限，只能考虑通过调用国产平台来实现。

​	国产平台虽然实现了`openai`库的支持，但是不支持`langchain_openai`，只能通过`langchain`的`Embeddings`来封装国产平台对`openai`支持。

​	以下是对国产平台豆包（火山云）进行封装

```python
from langchain_core.embeddings import Embeddings
from openai import OpenAI
import os
from typing import List, Dict, Any, Sequence, Union

class VolcArkEmbeddings(Embeddings):
    """火山方舟(VolcArk)文本嵌入模型的自定义实现"""
    
    def __init__(
        self,
        api_key: str = None,
        model: str = "doubao-embedding-text-240715",
        base_url: str = "https://ark.cn-beijing.volces.com/api/v3",
        encoding_format: str = "float",
        **kwargs: Any
    ):
        """
        初始化火山方舟嵌入模型
        
        Args:
            api_key: 火山方舟API密钥(默认从环境变量ARK_API_KEY获取)
            model: 使用的嵌入模型(默认'doubao-embedding-text-240715')
            base_url: API基础URL
            encoding_format: 编码格式(默认'float')
            kwargs: 其他传递给OpenAI客户端的参数
        """
        # 从环境变量获取API密钥如果没有显式提供
        self.api_key = api_key or os.environ.get("ARK_API_KEY")
        if not self.api_key:
            raise ValueError("未提供火山方舟API密钥，请设置ARK_API_KEY环境变量或直接传入api_key参数")
            
        # 初始化OpenAI客户端
        self.client = OpenAI(
            api_key=self.api_key,
            base_url=base_url,
            **kwargs
        )
        
        self.model = model
        self.encoding_format = encoding_format

    def _get_embeddings(self, texts: List[str]) -> List[List[float]]:
        """实际调用API获取嵌入向量"""
        response = self.client.embeddings.create(
            model=self.model,
            input=texts,
            encoding_format=self.encoding_format
        )
        # 按原始顺序提取嵌入向量
        return [item.embedding for item in response.data]

    def embed_documents(self, texts: List[str]) -> List[List[float]]:
        """为多个文本生成嵌入向量"""
        return self._get_embeddings(texts)

    def embed_query(self, text: str) -> List[float]:
        """为单个查询文本生成嵌入向量"""
        return self._get_embeddings([text])[0]

# ============= 使用示例 =============
if __name__ == "__main__":
    # 初始化嵌入模型 (自动使用环境变量ARK_API_KEY)
    embeddings = VolcArkEmbeddings(api_key = "")
    
    # 为单个查询生成嵌入
    print("查询嵌入形状:", len(embeddings.embed_query("花椰菜又称菜花、花菜")))
    
    # 为文档列表生成嵌入
    documents = [
        "花椰菜是一种十字花科蔬菜",
        "花椰菜富含维生素C和膳食纤维",
        "菜花是花椰菜的俗称"
    ]
    embeddings_list = embeddings.embed_documents(documents)
    print(f"生成 {len(embeddings_list)} 个文档嵌入")
    print("第一个嵌入维度:", len(embeddings_list[0]))
```



### rag实现

- `chroma`不必像是数据库一样，需要安装。它直接存在于代码间，直接存在于内存中，不需要额外安装程序。

```python
# main.py
from volcark import VolcArkEmbeddings

import bs4
from langchain import hub
from langchain_chroma import Chroma
from langchain_community.document_loaders import WebBaseLoader
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough
from langchain_openai import OpenAIEmbeddings
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_openai import ChatOpenAI

import os   

os.environ['ANONYMIZED_TELEMETRY'] = 'False'

from langchain_core.prompts import ChatPromptTemplate

def format_docs(docs):
    return "\n\n".join(doc.page_content for doc in docs)


def test_rag():
    '''
    使用官方的示例，在一个网站上构建一个问答应用程序。我们将使用Lilian Weng的LLM Powered Autonomous Agents博客文章作为特定的网站，这个网站允许我们提问关于博客内容的问题。
    '''
    
    # 1 调用 langchain 自带的 webbaseloader
    # 加载、分块和索引博客内容。
    loader = WebBaseLoader(
        web_paths=("https://lilianweng.github.io/posts/2023-06-23-agent/",),
        bs_kwargs=dict(
            parse_only=bs4.SoupStrainer(
                class_=("post-content", "post-title", "post-header")
            )
        ),
    )
    docs = loader.load()

    text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
    splits = text_splitter.split_documents(docs)

    # 创建 embeddings
    embeddings = VolcArkEmbeddings(api_key = <api_key>)
    # 创建 chroma 向量数据库
    vectorstore = Chroma.from_documents(documents=splits, embedding = embeddings)


    # 检索并生成博客的相关片段。
    retriever = vectorstore.as_retriever(search_type="similarity", search_kwargs={"k": 10})

	# 创建模型实例
    llm = ChatOpenAI(base_url="https://api.deepseek.com/v1", api_key = <api_key>, 
                     model="deepseek-chat")
 


    # 3. 使用更合适的ChatPromptTemplate (解决您的输入格式问题)
    system_template = """
    You are an assistant for question-answering tasks. 
    Use the following pieces of retrieved context to answer the question. 
    If you don't know the answer, just say that you don't know. 
    Use three sentences maximum and keep the answer concise.
    """
    prompt = ChatPromptTemplate.from_messages([
        ("system", system_template),
        ("human", "Question: {question}\nContext: {context}")
    ])

    # 4. 创建链 
    # # LangChain 会将整个字典视为一个 RunnableParallel 对象，它的两个键分别对应两个并行运行的子链。
    rag_chain = (
        {
            # 获取并格式化检索结果
            # retriever | format_docs 时，LangChain 会自动将 format_docs 函数
            # 封装成一个 RunnableLambda 对象。所以，这等价于：
            # from langchain_core.runnables import RunnableLambda
            # chain = retriever | RunnableLambda(format_docs)
            "context": retriever | format_docs,
            
            # 直接传递问题 (可自定义)
            # RunnablePassthrough是一个特殊的可运行对象（Runnable），它的主要作用是传递输入数据。
            # 它不会对输入数据进行任何修改，只是将输入原封不动地传递到输出。
            # 在构建复杂的处理链时，它用于将原始输入数据或中间数据传递到链的后续步骤。
            "question": RunnablePassthrough() | (
                # 可选：添加问题预处理
                lambda x: x.strip("?") + "?"  # 确保以?结尾
            )
        }
        | prompt
        | llm  
        | StrOutputParser()  # 确保输出为纯文本
    )

    # lagnchain 官网原始代码
    # rag_chain = (
    #     {"context": retriever | format_docs, "question": RunnablePassthrough()}
    #     | prompt
    #     | llm
    #     | StrOutputParser()
    # )

    res = rag_chain.invoke("What is Task Decomposition?")
    print(res)
    # 清理
    vectorstore.delete_collection()

if __name__ == "__main__":
    test_rag()
```



### chain链详解

```python
rag_chain = (
    {
        "context": retriever | format_docs,
        "question": RunnablePassthrough() | (
            lambda x: x.strip("?") + "?"  # 确保以?结尾
        )
    }
    | prompt
    | llm  
    | StrOutputParser()  # 确保输出为纯文本
)
```



​	首先，我们可以看到，链条的初始端是字典`{...}`，是什么意思呢，LangChain 会将整个**字典**视为一个 RunnableParallel 对象，它的两个键分别对应两个并行运行的子链。

​	所以，input 输入这个链条的时候，查找input相似度高的文本，格式化后和question一块输入prompt，然后prompt输入到大模型中，最终获得我们需要的答案。

