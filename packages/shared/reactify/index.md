---
category: Reactivity
alias: createReactiveFn
---

# reactify

Converts plain functions into reactive functions. The converted function accepts refs as its arguments and returns a ComputedRef, with proper typing.

将普通函数转变成响应式函数。转换后的函数以 `refs` 作为参数，并返回一个 `ComputedRef`，并且有正确的类型推导。

::: tip
Interested to see some application or looking for some pre-reactified functions? 

Check out [⚗️ Vue Chemistry](https://github.com/antfu/vue-chemistry)!
:::

## Usage 使用方式

Basic example

基础示例

```ts
import { reactify } from '@vueuse/core'

// a plain function
function add(a: number, b: number): number {
  return a + b
}

// now it accept refs and returns a computed ref
// (a: number | Ref<number>, b: number | Ref<number>) => ComputedRef<number>
const reactiveAdd = reactify(add)

const a = ref(1)
const b = ref(2)
const sum = reactiveAdd(a, b)

console.log(sum.value) // 3

a.value = 5

console.log(sum.value) // 7
```

An example of implementing a reactive [Pythagorean theorem](https://en.wikipedia.org/wiki/Pythagorean_theorem).

一个响应式[勾股定理](https://en.wikipedia.org/wiki/Pythagorean_theorem) 的示例。

```ts
import { reactify } from '@vueuse/core'

const pow = reactify(Math.pow)
const sqrt = reactify(Math.sqrt)
const add = reactify((a: number, b: number) => a + b)

const a = ref(3)
const b = ref(4)
const c = sqrt(add(pow(a, 2), pow(b, 2)))
console.log(c.value) // 5

// 5:12:13
a.value = 5
b.value = 12
console.log(c.value) // 13
```

You can also do it this way:

```ts
import { reactify } from '@vueuse/core'

function pythagorean(a: number, b: number) {
  return Math.sqrt(a ** 2 + b ** 2)
}

const a = ref(3)
const b = ref(4)

const c = reactify(pythagorean)(a, b)
console.log(c.value) // 5
```

Another example of making reactive `stringify`

另一个是 `stringify` 的示例。

```ts
import { reactify } from '@vueuse/core'

const stringify = reactify(JSON.stringify)

const obj = ref(42)
const dumped = stringify(obj)

console.log(dumped.value) // '42'

obj.value = { foo: 'bar' }

console.log(dumped.value) // '{"foo":"bar"}'
```
