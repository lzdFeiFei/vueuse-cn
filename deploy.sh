cd packages/.vitepress/dist

git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:vueuse-cn/vueuse-cn.git main:main