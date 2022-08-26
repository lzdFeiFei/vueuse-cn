---
category: Reactivity
---

# reactifyObject

Apply `reactify` to an object

将 `reactify` 用于对象

## Usage

```ts
import { reactifyObject } from '@vueuse/core'

const reactifiedConsole = reactifyObject(console)

const a = ref('42')

reactifiedConsole.log(a) // no longer need `.value`
```
