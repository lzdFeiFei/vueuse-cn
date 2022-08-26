---
category: Reactivity
alias: controlledRef
related: computedWithControl
---

# refWithControl

Fine-grained controls over ref and its reactivity. (Vue 3 Only)

ref 及其响应性的细粒度控制。

## Usage 使用

`refWithControl` uses `extendRef` to provide two extra functions `get` and `set` to have better control over when it should track/trigger the reactivity.

`refWithControl` 使用 `extendRef` 提供了两个额外的函数 `get` 和 `set` 以便更好的控制何时应该进行 `track/trigger` 。

```ts
import { refWithControl } from '@vueuse/core'

const num = refWithControl(0)
const doubled = computed(() => num.value * 2)

// just like normal ref
num.value = 42
console.log(num.value) // 42
console.log(doubled.value) // 84

// set value without triggering the reactivity
num.set(30, false)
console.log(num.value) // 30
console.log(doubled.value) // 84 (doesn't update)

// get value without tracking the reactivity
watchEffect(() => {
  console.log(num.peek())
}) // 30

num.value = 50 // watch effect wouldn't be triggered since it collected nothing.
console.log(doubled.value) // 100 (updated again since it's a reactive set)
```

### `peek`, `lay`, `untrackedGet`, `silentSet`

We also provide some shorthands for doing the get/set without track/triggering the reactivity system. The following lines are equivalent.

我们还提供了一些不触发 `track/trigger` 的反应性系统的情况下进行 `get/set` 的简写。以下几行的写法是等效的。

```ts
const foo = refWithControl('foo')
```

```ts
// getting
foo.get(false)
foo.untrackedGet()
foo.peek() // an alias for `untrackedGet`
```

```ts
// setting
foo.set('bar', false)
foo.silentSet('bar')
foo.lay('bar') // an alias for `silentSet`
```

## Configurations 配置

### `onBeforeChange()`

`onBeforeChange` option is offered to give control over if a new value should be accepted. For example:

`onBeforeChange` 选项是用来控制是否接受新值。例如：

```ts
const num = refWithControl(0, {
  onBeforeChange(value, oldValue) {
    // disallow changes larger then ±5 in one operation
    if (Math.abs(value - oldValue) > 5)
      return false // returning `false` to dismiss the change
  },
})

num.value += 1
console.log(num.value) // 1

num.value += 6
console.log(num.value) // 1 (change been dismissed)
```

### `onChanged()`

`onChanged` option offers a similar functionally as Vue's `watch` but being synchronoused with less overhead compare to `watch`.

`onChanged` 选项和 Vue 的 `watch` 功能相同，但是有更小的同步性能消耗。

```ts
const num = refWithControl(0, {
  onChanged(value, oldValue) {
    console.log(value)
  },
})
```
