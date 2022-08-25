---
category: Reactivity
alias: eagerComputed
---

# computedEager

Eager computed without lazy evaluation.

及时计算而不是懒计算。

Learn more at [Vue: When a computed property can be the wrong tool](https://dev.to/linusborg/vue-when-a-computed-property-can-be-the-wrong-tool-195j).

阅读 [Vue: When a computed property can be the wrong tool](https://dev.to/linusborg/vue-when-a-computed-property-can-be-the-wrong-tool-195j) 了解更多。

- Use `computed()` when you have a complex calculation going on, which can actually profit from caching and lazy evaluation and should only be (re-)calculated if really necessary. 
- Use `computedEager()` when you have a simple operation, with a rarely changing return value – often a boolean.

- 复杂的计算请使用 `computed()`，可以从缓存结果和懒计算中获益，并且仅应该在必要的时候（重新）计算。
- 简单的操作并且返回值很少改变，通常是布尔值，这种情况请使用 `computedEager()`，

## Usage

```js
import { computedEager } from '@vueuse/core'

const todos = ref([])
const hasOpenTodos = computedEager(() => !!todos.length)

console.log(hasOpenTodos.value) // false
toTodos.value.push({ title: 'Learn Vue' })
console.log(hasOpenTodos.value) // true
```
