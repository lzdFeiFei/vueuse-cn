# Guidelines 指导方针

Here are the guidelines for VueUse functions. You could also take them as a reference for authoring your own composable functions or apps.

这里是 VueUse 函数的指导方针。你还可以将它们作为参考来编写你自己的可组合函数或应用程序。

You can also find some reasons for those design decisions and also some tips for writing composable functions with [Anthony Fu](https://github.com/antfu)'s talk about VueUse:

你还可以在 [Anthony Fu](https://github.com/antfu) 关于 VueUse 的演讲中找到这些设计决策的一些原因以及编写可组合函数的一些技巧：

- [Composable Vue](https://antfu.me/posts/composable-vue-vueday-2021) - at VueDay 2021
- [可组合的 Vue](https://antfu.me/posts/composable-vue-vueconf-china-2021) - at VueConf China 2021 (in Chinese)

## General 一般原则

- Import all Vue APIs from `"vue-demi"`
- Use `ref` instead `reactive` whenever possible
- Use options object as arguments whenever possible to be more flexible for future extensions.
- Use `shallowRef` instead of `ref` when wrapping large amounts of data.
- Use `configurableWindow` (etc.) when using global variables like `window` to be flexible when working with multi-windows, testing mocks, and SSR.
- When involved with Web APIs that are not yet implemented by the browser widely, also outputs `isSupported` flag
- When using `watch` or `watchEffect` internally, also make the `immediate` and `flush` options configurable whenever possible
- Use `tryOnUnmounted`  to clear the side-effects gracefully
- Avoid using console logs
- When the function is asynchronous, return a PromiseLike

- 从 `"vue-demi"` 导入所有的 Vue APIs ；
- 尽可能使用 `ref` 而不是 `reactive` ；
- 使用选项对象形式作为参数，以便未来更灵活的扩展；
- 包裹大量数据的时候尽可能使用 `shallowRef` 而不是 `ref` ；
- 在使用全局变量，例如 `window` 时，使用 `configurableWindow`（等），以便在处理多窗口、测试模拟和 SSR 时更灵活。
- 当涉及浏览器尚未广泛支持的 Web API 时，还应输出 `isSupported` 标志
- 当在内部使用 `watch` 或者 `watchEffect` 时，还应尽可能配置 `immediate` 和 `flush` 选项；
- 使用 `tryOnUnmounted` 优雅地清除副作用；
- 避免使用 `console logs` ；
- 当函数为异步时，返回PromiseLike 对象；

Read also: [Best Practice](./guide/best-practice.md)

另请阅读： [最佳实践](./guide/best-practice.md)

## ShallowRef

Use `shallowRef` instead of `ref` when wrapping large amounts of data.

包裹大量数据的时候尽可能使用 `shallowRef` 而不是 `ref`

```ts
export function useFetch<T>(url: MaybeRef<string>) {
  // use `shallowRef` to prevent deep reactivity
  const data = shallowRef<T | undefined>()
  const error = shallowRef<Error | undefined>()

  fetch(unref(url))
    .then(r => r.json())
    .then(r => data.value = r)
    .catch(e => error.value = e)

  /* ... */
}
```

## Configurable Globals 可配置全局变量

When using global variables like `window` or `document`, support `configurableWindow` or `configurableDocument` in the options interface to make the function flexible when for scenarios like multi-windows, testing mocks, and SSR.

在使用全局变量，例如 `window` 或 `document` 时，要在选项接口中支持 `configurableWindow` 或 `configurableDocument` ，以便在面对处理多窗口、测试模拟和 SSR 等场景时更灵活。

Learn more about the implementation: [`_configurable.ts`](https://github.com/vueuse/vueuse/blob/main/packages/core/_configurable.ts)

了解有关实现的更多信息：[`_configurable.ts`](https://github.com/vueuse/vueuse/blob/main/packages/core/_configurable.ts)

```ts
import type { ConfigurableWindow } from '../_configurable'
import { defaultWindow } from '../_configurable'

export function useActiveElement<T extends HTMLElement>(
  options: ConfigurableWindow = {},
) {
  const {
    // defaultWindow = isClient ? window : undefined
    window = defaultWindow,
  } = options

  let el: T

  // skip when in Node.js environment (SSR)
  if (window) {
    window.addEventListener('blur', () => {
      el = window?.document.activeElement
    }, true)
  }

  /* ... */
}
```

Usage example:

```ts
// in iframe and bind to the parent window
useActiveElement({ window: window.parent })
```

## Watch Options Watch 选项

When using `watch` or `watchEffect` internally, also make the `immediate` and `flush` options configurable whenever possible. For example `watchDebounced`:

当在内部使用 `watch` 或者 `watchEffect` 时，还应尽可能配置 `immediate` 和 `flush` 选项。以 `watchDebounced` 为例：

```ts
import type { WatchOptions } from 'vue-demi'

// extend the watch options
export interface WatchDebouncedOptions extends WatchOptions {
  debounce?: number
}

export function watchDebounced(
  source: any,
  cb: any,
  options: WatchDebouncedOptions = {},
): WatchStopHandle {
  return watch(
    source,
    () => { /* ... */ },
    options, // pass watch options
  )
}
```

## Controls 控制

We use the `controls` option allowing users to use functions with a single return for simple usages, while being able to have more controls and flexibility when needed. Read more: [#362](https://github.com/vueuse/vueuse/pull/362).

我们使用 `controls` 选项，允许用户使用带有单一返回的函数，以便简单使用，同时在需要时能够拥有更多的可控性和灵活性。

#### When to provide a `controls` option

- The function is more commonly used with single `ref` or 
- Examples: `useTimestamp`, `useInterval`,

```ts
// common usage
const timestamp = useTimestamp()

// more controls for flexibility
const { timestamp, pause, resume } = useTimestamp({ controls: true })
```

Refer to `useTimestamp`'s source code for the implementation of proper TypeScript support.

#### When **NOT** to provide a `controls` option

- The function is more commonly used with multiple returns
- Examples: `useRafFn`, `useRefHistory`,

```ts
const { pause, resume } = useRafFn(() => {})
```

## `isSupported` Flag

When involved with Web APIs that are not yet implemented by the browser widely, also outputs `isSupported` flag.

当涉及浏览器尚未广泛支持的 Web API 时，还应输出 `isSupported` 标志

For example `useShare`:

以 `useShare` 为例：

```ts
export function useShare(
  shareOptions: MaybeRef<ShareOptions> = {},
  options: ConfigurableNavigator = {},
) {
  const { navigator = defaultNavigator } = options
  const isSupported = useSupported(() => navigator && 'canShare' in navigator)

  const share = async (overrideOptions) => {
    if (isSupported.value) {
      /* ...implementation */
    }
  }

  return {
    isSupported,
    share,
  }
}
```

## Asynchronous Composables

When a composable is asynchronous, like `useFetch`, it is a good idea to return a PromiseLike object from the composable
so the user is able to await the function. This is especially useful in the case of Vue's `<Suspense>` api.

当函数为异步时，例如 `useFetch`，返回 PromiseLike 对象是一个好主意，以便用户可以用 `await` 。这在Vue的 `<Suspense>` api 中尤其有用。

- Use a `ref` to determine when the function should resolve e.g. `isFinished`
- Store the return state in a variable as it must be returned twice, once in the return and once in the promise.
- The return type should be an intersection between the return type and a PromiseLike, e.g. `UseFetchReturn & PromiseLike<UseFetchReturn>`

- 使用一个 `ref` 来判定什么时候函数应该返回成功，例如 `isFinished` ；
- 将返回状态存储到一个变量中，因为它一定会被使用两次， 一次是在函数的返回值里一次是在 promise 里；
- 函数最终的返回类型应该是预期的返回对象类型和 PromiseLike 之间的交集， 例如：`UseFetchReturn & PromiseLike<UseFetchReturn>`

```ts
export function useFetch<T>(url: MaybeRef<string>): UseFetchReturn<T> & PromiseLike<UseFetchReturn<T>> {
  const data = shallowRef<T | undefined>()
  const error = shallowRef<Error | undefined>()
  const isFinished = ref(false)

  fetch(unref(url))
    .then(r => r.json())
    .then(r => data.value = r)
    .catch(e => error.value = e)
    .finally(() => isFinished.value = true)

  // Store the return state in a variable
  const state: UseFetchReturn<T> = {
    data,
    error,
    isFinished,
  }

  return {
    ...state,
    // Adding `then` to an object allows it to be awaited.
    then(onFulfilled, onRejected) {
      return new Promise<UseFetchReturn<T>>((resolve, reject) => {
        until(isFinished)
          .toBeTruthy()
          .then(() => resolve(state))
          .then(() => reject(state))
      }).then(onFulfilled, onRejected)
    },
  }
}
```


## Renderless Components 无渲染组件

- Use render functions instead of Vue SFC
- Wrap the props in `reactive` to easily pass them as props to the slot
- Prefer to use the functions options as prop types instead of recreating them yourself
- Only wrap the slot in an HTML element if the function needs a target to bind to

- 使用渲染函数而不是 Vue SFC
- 使用 `reactive` 包裹 props 便于传递给插槽
- 更喜欢将函数选项用作 props 类型，而不是自己重新创建它们
- 仅当函数需要绑定到目标时，才将插槽包装到 HTML 元素中

```ts
import { defineComponent, reactive } from 'vue-demi'
import type { MouseOptions } from '@vueuse/core'
import { useMouse } from '@vueuse/core'

export const UseMouse = defineComponent<MouseOptions>({
  name: 'UseMouse',
  props: ['touch', 'resetOnTouchEnds', 'initialValue'] as unknown as undefined,
  setup(props, { slots }) {
    const data = reactive(useMouse(props))

    return () => {
      if (slots.default)
        return slots.default(data)
    }
  },
})
```

Sometimes a function may have multiple parameters, in that case, you maybe need to create a new interface to merge all the interfaces
into a single interface for the component props.

有时一个函数可能有多个参数，在这种情况下，可能需要创建一个新接口，将所有接口合并为的单个接口供组件 props 使用。

```ts
import type { TimeAgoOptions } from '@vueuse/core'
import { useTimeAgo } from '@vueuse/core'

interface UseTimeAgoComponentOptions extends Omit<TimeAgoOptions<true>, 'controls'> {
  time: MaybeRef<Date | number | string>
}

export const UseTimeAgo = defineComponent<UseTimeAgoComponentOptions>({ /* ... */ })
```
