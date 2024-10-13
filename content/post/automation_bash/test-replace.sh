md_file=<MD File>
jekyll_image_path=../../assets/blog
# 修改图片的引用路径
sed -i 's/\](images\//\](\/assets\/images\//g'  $md_file

# 把图片拷贝到Jekyll的图片目录
file_folder=$(dirname "$md_file")
file_name=$(basename "$md_file")
cp $file_folder/images/* $jekyll_image_path