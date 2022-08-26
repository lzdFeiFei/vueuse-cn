---
category: Reactivity
related: syncRef
---

# syncRefs

Keep target refs in sync with a source ref

保证 `target ref` 和 `source ref` 值的同步。

## Usage 使用方式

```ts
import { syncRefs } from '@vueuse/core'

const source = ref('hello')
const target = ref('target')

const stop = syncRefs(source, target)

console.log(target.value) // hello

source.value = 'foo'

console.log(target.value) // foo
```

## Watch options

The options for `syncRefs` are similar to `watch`'s `WatchOptions` but with different default values.

`syncRefs` 的选项和 `watch` 的 `WatchOptions` 相同，但是具有不同的默认值。

```ts
export interface SyncRefOptions {
  /**
   * Timing for syncing, same as watch's flush option
   *
   * @default 'sync'
   */
  flush?: WatchOptions['flush']
  /**
   * Watch deeply
   *
   * @default false
   */
  deep?: boolean
  /**
   * Sync values immediately
   *
   * @default true
   */
  immediate?: boolean
}
```

When setting `{ flush: 'pre' }`, the target reference will be updated at [the end of the current "tick"](https://vuejs.org/guide/essentials/watchers.html#callback-flush-timing) before rendering starts.

当设置 `{ flush: 'pre' }`， `target ref` 将会在 [当前 "tick" 的最后](https://vuejs.org/guide/essentials/watchers.html#callback-flush-timing) 更新，在渲染开始之前。

```ts
import { syncRefs } from '@vueuse/core'

const source = ref('hello')
const target = ref('target')

syncRefs(source, target, { flush: 'pre' })

console.log(target.value) // hello

source.value = 'foo'

console.log(target.value) // hello <- still unchanged, because of flush 'pre'

await nextTick()

console.log(target.value) // foo <- changed!
```
