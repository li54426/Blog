---
layout: blog
banana: true
category: algorithm
title:  
date:   2024-06-02 10:54:45
background: purple
tags:
- algorithm
---

* content
{:toc}




#### 首个数据特殊

[100311. 无需开会的工作日](https://leetcode.cn/problems/count-days-without-meetings/description/)

给你一个正整数 days，表示员工可工作的总天数（从第 1 天开始）。另给你一个二维数组 meetings，长度为 n，其中 meetings[i] = [start_i, end_i] 表示第 i 次会议的开始和结束天数（包含首尾）。

返回员工可工作且没有安排会议的天数。

注意：会议时间可能会有重叠。

> 示例 1：
>
> 输入：days = 10, meetings = [[5,7],[1,3],[9,10]]
>
> 输出：2
>
> 解释：
>
> 第 4 天和第 8 天没有安排会议。
>
> 示例 2：
>
> 输入：days = 5, meetings = [[2,4],[1,3]]
>
> 输出：1
>
> 解释：
>
> 第 5 天没有安排会议。
>
> 示例 3：
>
> 输入：days = 6, meetings = [[1,6]]
>
> 输出：0
>
> 解释：
>
> 所有工作日都安排了会议。

```c++
class Solution {
public:
    int countDays(int days, vector<vector<int>>& meetings) {
        // 会议时间可能会有重叠。
        sort(meetings.begin(), meetings.end());
        
        int len = meetings.size();
        if(len < 1){
            return days;
        }

        // 开始状态
        int start = meetings[0][0], end = meetings[0][1];
        int res = meetings[0][0]- 1;
        
        for(auto p : meetings){
            if(p[0] > end){
                res+= (p[0]- end -1);
            }
            
            // start = p[0];
            end = max(p[1], end);
        }
        
        res += (days - end);
        return res;
    }
};
```







[56. 合并区间 - 力扣（LeetCode）](https://leetcode.cn/problems/merge-intervals/description/)



```c++
class Solution {
public:
    vector<vector<int>> merge(vector<vector<int>>& nums) {
        if(nums.size()==1){
            return nums;
        }

        sort(nums.begin(), nums.end(), [](auto &a, auto &b){
            if(a[0] == b[0]){
                return a[1]<b[1];
            }
            return a[0]< b[0];
        });

        int l= nums[0][0], r  =nums[0][1];
        auto res = nums;
        res.clear();
        for(int i =1; i<nums.size(); ++i){
            if(nums[i][0] > r){
                // 不相交
                res.push_back({l, r});
                l = nums[i][0];
                r = nums[i][1];
            }
            else{
                l = min(l, nums[i][0]);
                r = max(r, nums[i][1]);
            }

            if(i == nums.size()-1){
                res.push_back({l, r});
            }

        }
        return res;

    }
};
```





```c++
class Solution {
public:
    vector<vector<int>> merge(vector<vector<int>>& intervals) {
        ranges::sort(intervals); // 按照左端点从小到大排序
        vector<vector<int>> ans;
        for (auto& p : intervals) {
            if (!ans.empty() && p[0] <= ans.back()[1]) { // 可以合并
                ans.back()[1] = max(ans.back()[1], p[1]); // 更新右端点最大值
            } else { // 不相交，无法合并
                ans.emplace_back(p); // 新的合并区间
            }
        }
        return ans;
    }
};
```

