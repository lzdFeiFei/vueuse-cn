---
category: Reactivity
alias: controlledComputed
---

# computedWithControl

Explicitly define the dependencies of computed.

显式定义计算属性的依赖。

## Usage

```ts
import { computedWithControl } from '@vueuse/core'

const source = ref('foo')
const counter = ref(0)

const computedRef = computedWithControl(
  () => source.value, // watch source, same as `watch`
  () => counter.value, // computed getter, same as `computed`
)
```

With this, the changes of `counter` won't trigger `computedRef` to update but the `source` ref does.

这种情况下，只有 `source` 的改变会触发 `computedRef` 的更新，而改变 `counter` 不会。

```ts
console.log(computedRef.value) // 0

counter.value += 1

console.log(computedRef.value) // 0

source.value = 'bar'

console.log(computedRef.value) // 1
```

### Manual Triggering 手动触发

> This only works in Vue 3
> 只在 Vue3 下生效

You can also manually trigger the update of the computed by:

可以通过以下方式主动触发更新：

```ts
const computedRef = computedWithControl(
  () => source.value,
  () => counter.value,
)

computedRef.trigger()
```
