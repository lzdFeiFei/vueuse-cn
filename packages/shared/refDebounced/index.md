---
category: Reactivity
alias: useDebounce, debouncedRef
---

# refDebounced

Debounce execution of a ref value.

具有防抖功能的 ref。

## Usage 使用

```js {4}
import { refDebounced } from '@vueuse/core'

const input = ref('foo')
const debounced = refDebounced(input, 1000)

input.value = 'bar'
console.log(debounced.value) // 'foo'

await sleep(1100)

console.log(debounced.value) // 'bar'
```
You can also pass an optional 3rd parameter including maxWait option. See `useDebounceFn` for details.

还可以传递包括 `maxWati` 选项在内的第三个可选在参数。详见 `useDebounceFn`。

## Recommended Reading

- [**Debounce vs Throttle**: Definitive Visual Guide](https://redd.one/blog/debounce-vs-throttle)
