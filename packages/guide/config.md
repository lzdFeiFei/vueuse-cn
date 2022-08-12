# Configurations 配置

These show the general configurations for most of the functions in VueUse.

下述内容显示了 Vuese 中大部分函数的通用配置。


### Event Filters

From v4.0, we provide the Event Filters system to give the flexibility to control when events will get triggered. For example, you can use `throttleFilter` and `debounceFilter` to control the event trigger rate:

从 4.0 版本开始，我们提供了 Event Filters 系统来灵活控制事件的触发时机。例如，你可以使用 `throttleFilter` 和 `debounceFilter` 来控制事件触发率：

```ts
import { debounceFilter, throttleFilter, useLocalStorage, useMouse } from '@vueuse/core'

// changes will write to localStorage with a throttled 1s
const storage = useLocalStorage('my-key', { foo: 'bar' }, { eventFilter: throttleFilter(1000) })

// mouse position will be updated after mouse idle for 100ms
const { x, y } = useMouse({ eventFilter: debounceFilter(100) })
```

Moreover, you can utilize `pausableFilter` to temporarily pause some events.

此外，可以使用 `pausableFilter` 临时停止某些事件。

```ts
import { pausableFilter, useDeviceMotion } from '@vueuse/core'

const motionControl = pausableFilter()

const motion = useDeviceMotion({ eventFilter: motionControl.eventFilter })

motionControl.pause()

// motion updates paused

motionControl.resume()

// motion updates resumed
```

### Reactive Timing 响应式时机

VueUse's functions follow Vue's reactivity system defaults for [flush timing](https://vuejs.org/guide/essentials/watchers.html#callback-flush-timing) where possible.

Vueuse 的函数尽可能的遵循了 Vue 响应式系统的默认 [flush timing （触发时机）](https://vuejs.org/guide/essentials/watchers.html#callback-flush-timing)

For `watch`-like composables (e.g. `pausableWatch`, `whenever`, `useStorage`, `useRefHistory`) the default is `{ flush: 'pre' }`. Which means they will buffer invalidated effects and flush them asynchronously. This avoids unnecessary duplicate invocation when there are multiple state mutations happening in the same "tick".

对于类 `watch` 的组合函数（例如 `pausableWatch`, `whenever`, `useStorage`, `useRefHistory` ）的默认选项是 `{ flush: 'pre' }`。这意味着它们将推迟无效的效果并异步刷新它们。当同一个 “tick” 中发生多次状态改变时，这避免了不必要的重复调用。

In the same way as with `watch`, VueUse allows you to configure the timing by passing the `flush` option:

同 `watch` 的使用方式一样， VueUse 允许你通过传入 `flush` 选项来配置触发时机：

```ts
const { pause, resume } = pausableWatch(
  () => {
    // Safely access updated DOM
  },
  { flush: 'post' },
)
```

**flush option (default: `'pre'`)**
- `'pre'`: buffers invalidated effects in the same 'tick' and flushes them before rendering
- `'post'`: async like 'pre' but fires after component updates so you can access the updated DOM
- `'sync'`: forces the effect to always trigger synchronously

**触发选项 （默认值： `'pre'`）**
- `'pre'`: 在同一个 ‘tick’ 中推迟无效的效果并在渲染前触发
- `'post'`: 异步过程类似于 'pre' ，但在组件更新后触发，因此可以访问更新后的 DOM
- `'sync'`: 强制效果始终同步触发

**Note:** For `computed`-like composables (e.g. `syncRef`, `controlledComputed`), when flush timing is configurable, the default is changed to `{ flush: 'sync' }` to align them with the way computed refs works in Vue.

**Note:** 对于类 `computed` 的组合函数 （例如：`syncRef`, `controlledComputed`），当触发时机可以配置时， 默认值将改为 `{ flush: 'sync' }` 以便将其和 Vue 中的计算属性工作方式对齐。

### Configurable Global Dependencies 可配置的全局依赖

From v4.0, functions that access the browser APIs will provide an option fields for you to specify the global dependencies (e.g. `window`, `document` and `navigator`). It will use the global instance by default, so for most of the time, you don't need to worry about it. This configure is useful when working with iframes and testing environments.

从 4.0 版本开始，为访问浏览器 API 的函数提供一个选项字段，可以指定全局依赖（例如：`window`, `document` 和 `navigator`）。该选项默认使用全局实例，多数情况下无需关注。当使用 iframe 和测试环境时，此配置非常有用。

```ts
// accessing parent context
const parentMousePos = useMouse({ window: window.parent })

const iframe = document.querySelect('#my-iframe')

// accessing child context
const childMousePos = useMouse({ window: iframe.contextWindow })
```

```ts
// testing
const mockWindow = { /* ... */ }

const { x, y } = useMouse({ window: mockWindow })
```
