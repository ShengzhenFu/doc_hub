#!/bin/sh
echo "clean data in public"
cd /home/shengzhen/hugo/docdock/public
rm -r *  
echo "switch to /home/shengzhen/hugo/docdock/"
cd /home/shengzhen/hugo/docdock
echo "switched to /home/shengzhen/hugo/docdock/" 
hugo --theme=docdock --baseUrl="https://shengzhenfu.github.io/"
echo "web has been deployed to public folder"
echo "copy from public to local git repo" 
cp -r -u /home/shengzhen/hugo/docdock/public/. /home/shengzhen/github.io/ShengzhenFu.github.io/ 
echo "completed copy to locAl git repo"
echo "switch to local git repo folder"
cd /home/shengzhen/github.io/ShengzhenFu.github.io/
echo "start to git commit to github repo io"
git add .
git commit -a -m "doc hub"
git push -u origin master
echo "publish to git io web completed"
cd /home/shengzhen/hugo/docdock
echo "switched to /home/shengzhen/hugo/docdock/"
git add .
git commit -a -m "doc_hub source"
git push -u origin master
echo "complete git commit the hugo source of doc_hub"

