---
category: Reactivity
alias: asyncComputed
---

# computedAsync

Computed for async functions

异步函数的计算属性

## Usage 用法

```js
import { ref } from 'vue'
import { computedAsync } from '@vueuse/core'

const name = ref('jack')

const userInfo = computedAsync(
  async () => {
    return await mockLookUp(name.value)
  },
  null, // initial state
)
```

### Evaluation State 求值状态

You will need to pass a ref to track if the async function is evaluating,

需要传递一个 ref 来跟踪异步函数是否正在求值，

```js
import { ref } from 'vue'
import { computedAsync } from '@vueuse/core'

const evaluating = ref(false)

const userInfo = computedAsync(
  async () => { /* your logic */ },
  null,
  evaluating,
)
```

### onCancel 取消

When the computed source changed before the previous async function gets resolved, you may want to cancel the previous one. Here is an example showing how to incorporate with the fetch API.

在异步函数获取返回值之前，计算属性所依赖的响应式数据又发生了变化，这时你可能想要取消之前的请求。下面是基于 `fetch API` 的一个示例。

```js
const packageName = ref('@vueuse/core')

const downloads = computedAsync(async (onCancel) => {
  const abortController = new AbortController()

  onCancel(() => abortController.abort())

  return await fetch(
    `https://api.npmjs.org/downloads/point/last-week/${packageName.value}`,
    { signal: abortController.signal },
  )
    .then(response => response.ok ? response.json() : { downloads: '—' })
    .then(result => result.downloads)
}, 0)
```

### Lazy 惰性执行

By default, `computedAsync` will start resolving immediately on creation, specify `lazy: true` to make it start resolving on the first accessing.

默认情况下，`computedAsync` 创建后就开始执行， 指定 `lazy: true` 来在第一次使用计算属性时执行。

```js
import { ref } from 'vue'
import { computedAsync } from '@vueuse/core'

const evaluating = ref(false)

const userInfo = computedAsync(
  async () => { /* your logic */ },
  null,
  { lazy: true, evaluating },
)
```

## Caveats 警告

- Just like Vue's built-in `computed` function, `computedAsync` does dependency tracking and is automatically re-evaluated when dependencies change. Note however that only dependency referenced in the first call stack are considered for this. In other words: **Dependencies that are accessed asynchronously will not trigger re-evaluation of the async computed value.**

- 同 Vue 内置的 `computed` 相同的点是，`computedAsync` 收集依赖并在依赖改变时重新计算。但是，请注意，只有在第一个调用堆栈中引用的依赖才会被考虑。换句话说， **异步访问的依赖项不会触发对异步计算值的重新计算。**

- As opposed to Vue's built-in `computed` function, re-evaluation of the async computed value is triggered whenever dependencies are changing, regardless of whether its result is currently being tracked or not.

-  Vue 内置的 `computed` 不同的点是，每当依赖关系发生变化时，都会触发对异步计算属性的重新计算，无论其结果当前是否正在被跟踪。
