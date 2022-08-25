---
category: Reactivity
---

# extendRef

Add extra attributes to Ref.

给 Ref 添加额外的属性

## Usage 使用方式

> This function is **NOT compatible with Vue 2**.

> 该函数 **Vue 2 不适用**.

> Please note the extra attribute will not be accessible in Vue's template.

> 请注意在 Vue 模板中不会获取额外属性

```ts
import { ref } from 'vue'
import { extendRef } from '@vueuse/core'

const myRef = ref('content')

const extended = extendRef(myRef, { foo: 'extra data' })

extended.value === 'content'
extended.foo === 'extra data'
```

Refs will be unwrapped and be reactive

Refs 可以解包并且是响应式的。

```ts
const myRef = ref('content')
const extraRef = ref('extra')

const extended = extendRef(myRef, { extra: extraRef })

extended.value === 'content'
extended.extra === 'extra'

extended.extra = 'new data' // will trigger update
extraRef.value === 'new data'
```
