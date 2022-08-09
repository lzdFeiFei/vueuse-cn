# 最佳实践

### 解构

Most of the functions in VueUse returns an **object of refs** that you can use [ES6's object destructure](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment) syntax to take what you need. For example:

大多数 VueUse 里的函数返回的是 **refs 组成的对象**， 因此可以使用 [ES6's 对象解构](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment) 语法来获取你需要的东西。例如：

```ts
import { useMouse } from '@vueuse/core'

// "x" and "y" are refs
const { x, y } = useMouse()

console.log(x.value)

const mouse = useMouse()

console.log(mouse.x.value)
```

If you prefer to use them as object properties style, you can unwrap the refs by using `reactive()`. For example:

如果你更愿意使用对象属性风格，可以通过 `reactive()` 来解包 refs。

```ts
import { reactive } from 'vue'
import { useMouse } from '@vueuse/core'

const mouse = reactive(useMouse())

// "x" and "y" will be auto unwrapped, no `.value` needed
console.log(mouse.x)
```
