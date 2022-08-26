---
category: Reactivity
---

# reactiveComputed

Computed reactive object. Instead of returning a ref that `computed` does, `reactiveComputed` returns a reactive object.

响应式对象的计算属性。不同于 `computed` 返回一个 ref，`reactiveComputed` 返回一个响应式对象

<RequiresProxy />

## Usage

```ts
import { reactiveComputed } from '@vueuse/core'

const state = reactiveComputed(() => {
  return {
    foo: 'bar',
    bar: 'baz',
  }
})

state.bar // 'baz'
```
