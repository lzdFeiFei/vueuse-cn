# Get Started 开始

VueUse is a collection of utility functions based on [Composition API](https://v3.vuejs.org/guide/composition-api-introduction.html). We assume you are already familiar with the basic ideas of [Composition API](https://v3.vuejs.org/guide/composition-api-introduction.html) before you continue.

Vueuse 是一组基于 [Vue 组合式 API](https://v3.vuejs.org/guide/composition-api-introduction.html) 的实用函数合集。继续阅读之前我们假设你已经熟悉了  [Vue 组合式  API](https://v3.vuejs.org/guide/composition-api-introduction.html) 的基本概念。

## Installation 安装

> 🎩 From v4.0, it works for Vue 2 & 3 **within a single package** by the power of [vue-demi](https://github.com/vueuse/vue-demi)!
> 🎩 从 4.0 版本开始，借助于  [vue-demi](https://github.com/vueuse/vue-demi) 的能力，可以在一个包里同时支持 Vue 2 & 3

```bash
npm i @vueuse/core
```

[Add ons](/add-ons.html) | [Nuxt Module](/guide/index.html#nuxt)

> From v6.0, VueUse requires `vue` >= v3.2 or `@vue/composition-api` >= v1.1
> 
> 从 6.0 版本开始， Vueuse 需要 `vue` >= v3.2 或 `@vue/composition-api` >= v1.1

###### Demos

- [Vite + Vue 3](https://github.com/vueuse/vueuse-vite-starter)
- [Nuxt 3 + Vue 3](https://github.com/antfu/vitesse-nuxt3)
- [Webpack + Vue 3](https://github.com/vueuse/vueuse-vue3-example)
- [Nuxt 2 + Vue 2](https://github.com/antfu/vitesse-nuxt-bridge)
- [Vue CLI + Vue 2](https://github.com/vueuse/vueuse-vue2-example)

### CDN

```html
<script src="https://unpkg.com/@vueuse/shared"></script>
<script src="https://unpkg.com/@vueuse/core"></script>
```

It will be exposed to global as `window.VueUse`

将以 `window.VueUse` 的方式暴露到全局环境

### Nuxt

From v7.2.0, we shipped a Nuxt module to enable auto importing for Nuxt 3 and Nuxt Bridge.

从 7.2.0 版本开始，我们发布了一个 Nuxt 模块以便 Nuxt 3 和 Nuxt Bridge 可以自动导入

```bash
npm i -D @vueuse/nuxt @vueuse/core
```

Nuxt 3
```ts
// nuxt.config.ts
export default {
  modules: [
    '@vueuse/nuxt',
  ],
}
```

Nuxt 2
```ts
// nuxt.config.js
export default {
  buildModules: [
    '@vueuse/nuxt',
  ],
}
```

And then use VueUse function anywhere in your Nuxt app. For example:

之后就可以在 Nuxt app 中随意使用 Vueuse 函数了。例如：

```html
<script setup lang="ts">
const { x, y } = useMouse()
</script>

<template>
  <div>pos: {{x}}, {{y}}</div>
</template>
```

## Usage Example 使用示例

Simply importing the functions you need from `@vueuse/core`

只需从 `@vueuse/core` 中导入所需的函数


```ts
import { useLocalStorage, useMouse, usePreferredDark } from '@vueuse/core'

export default {
  setup() {
    // tracks mouse position
    const { x, y } = useMouse()

    // is user prefers dark theme
    const isDark = usePreferredDark()

    // persist state in localStorage
    const store = useLocalStorage(
      'my-storage',
      {
        name: 'Apple',
        color: 'red',
      },
    )

    return { x, y, isDark, store }
  },
}
```

Refer to [functions list](/functions) for more details.

参阅 [functions list](/functions) 获取更多细节。
