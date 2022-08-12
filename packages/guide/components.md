# Components 组件

In v5.0, we introduced a new package, `@vueuse/components` providing renderless component versions of composable functions.

在 5.0 版本，我们引入了一个新包，`@vueuse/components` 提供了可组合函数无渲染组件版本。

## Install 安装

```bash
$ npm i @vueuse/core @vueuse/components
```

## Usage 使用

For example of `onClickOutside`, instead of binding the component ref for functions to consume:

以 `onClickOutside` 为例，不用给组件绑定模板 ref 然后传递给函数： 

```html
<script setup>
import { ref } from 'vue'
import { onClickOutside } from '@vueuse/core'

const el = ref()

function close () {
  /* ... */
}

onClickOutside(el, close)
</script>

<template>
  <div ref="el">
    Click Outside of Me
  </div>
</template>
```

We can now use the renderless component which the binding is done automatically:

我们现在可以使用无渲染组件，绑定将自动完成：

```html
<script setup>
import { OnClickOutside } from '@vueuse/components'

function close () {
  /* ... */
}
</script>

<template>
  <OnClickOutside @trigger="close">
    <div>
      Click Outside of Me
    </div>
  </OnClickOutside>
</template>
```

## Return Value 返回值

You can access return values with `v-slot`:

可以通过 `v-slot` 获取返回值：

```html
<UseMouse v-slot="{ x, y }">
  x: {{ x }}
  y: {{ y }}
</UseMouse>
```

```html
<UseDark v-slot="{ isDark, toggleDark }">
  <button @click="toggleDark()">
    Is Dark: {{ isDark }}
  </button>
</UseDark>
```

Refer to each function's documentation for the detailed usage of component style.

参阅每个函数的文档详细了解组件风格的使用细节。
