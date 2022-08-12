# Contributing 贡献

Thanks for being interested in contributing to this project!

感谢您有兴趣为本项目做出贡献！

## Development 部署

### Setup 设置

Clone this repo to your local machine and install the dependencies.

克隆本仓库到你的本地并安装依赖

```bash
pnpm install
```

We use VitePress for rapid development and documenting. You can start it locally by

我们使用 VitePress 进行快速开发和记录。可以通过以下方式在本地启动：

```bash
pnpm dev
```

## Contributing 贡献

### Existing functions 已有函数

Feel free to enhance the existing functions. Please try not to introduce breaking changes.

请随意拓展现有函数的功能。请尽量不要引入破坏性的更改。

### New functions 新增函数

There are some notes for adding new functions

有一些关于添加新函数的提示：

- Before you start working, it's better to open an issue to discuss first.
- The implementation should be placed under `packages/core` as a folder and exposing in `index.ts`
- In the `core` package, try not to introduce 3rd-party dependencies as this package is aimed to be as lightweight as possible.
- If you'd like to introduce 3rd-party dependencies, please contribute to @vueuse/integrations or create a new add-on.
- You can find the function template under `packages/core/_template/`, details explained in the [Function Folder](#function-folder) section.
- When writing documentation for your function, the `<!--FOOTER_STARTS-->` and `<!--FOOTER_ENDS-->` will be automatically updated at build time, so don't feel the need to update them.

- 编写新函数之前，最好先开个 issue 讨论一下；
- 在 `packages/core` 下创建文件夹并实现新函数， 并在 `index.ts` 中暴露出来；
- 在 `core` 包里，尽量不要引入第三方依赖，因为本包旨在做到尽可能轻量；
- 如果需要引入第三方依赖，请再 `@vueuse/integrations` 下创建或者创建一个新的附加组件；
- 可以在 `packages/core/_template/` 找到函数模板， 详情参见 [函数文件夹](#function-folder) 板块；
- 当为新函数编写文档时，`<!--FOOTER_STARTS-->` 和 `<!--FOOTER_ENDS-->` 会在构建阶段自动生成，没有必要手动更新；

> Please note you don't need to update packages' `index.ts`. They are auto-generated.
> 请注意： 不必更新 `packages` 下的 `index.ts`. 它们是自动生成的。

### New add-ons 新增附加组件

New add-ons are greatly welcome!

非常欢迎添加新的附加组件！

- Create a new folder under `packages/`, name it as your add-on name. 
- Add add-on details in `scripts/packages.ts`
- Create `README.md` under that folder.
- Add functions as you would do to the core package.
- Commit and submit as a PR.

- 在 `packages/` 下新建一个文件夹，并以新附加组件的名字命名； 
- 在 `scripts/packages.ts` 中撰写附加组件的详情；
- 在新建的文件夹下创建 `README.md` 文档；
- 向 `core package` 中添加函数；
- 提交代码并且提个 PR

## Project Structure 项目结构

### Monorepo

We use monorepo for multiple packages

我们使用 `monorepo` 来管理多个包

```
packages
  shared/         - 共享的工具函数
  core/           - 核心包
  firebase/       - Firebase 附加组件
  [...addons]/    - 其它附加组件
```

### Function Folder 函数文件夹

A function folder typicality contains these 4 files:

一个典型的函数文件夹包含以下四个文件：

> You can find the template under `packages/core/_template/`
> 可以在 `packages/core/_template/` 找到函数模板

```bash
index.ts            # 函数源码
demo.vue            # 文档里的 demo
index.test.ts       # 基于 vitest 的测试
index.md            # 文档
```

for `index.ts` you should export the function with names.

需要在 `index.ts` 导出函数名

```ts
// DO
export { useMyFunction }

// DON'T
export default useMyFunction
```

for `index.md` the first sentence will be displayed as the short intro in the function list, so try to keep it brief and clear.

`index.md` 的第一个句子将作为简介在函数列表中展示，所以尽可能保证简洁明了。

```md
# useMyFunction

This will be the intro. The detail descriptions...
```

Read more about the [guidelines](https://vueuse.org/guidelines).

阅读有关 [指导方针](https://vueuse.org/guidelines) 的内容.

## Code Style 代码风格

Don't worry about the code style as long as you install the dev dependencies. Git hooks will format and fix them for you on committing.
只要安装了开发依赖，就不用担心代码格式。Git hooks 将在提交时格式化并修复代码。

## Thanks 致谢

Thank you again for being interested in this project! You are awesome!

再次感谢您对本项目感兴趣！你真棒！
