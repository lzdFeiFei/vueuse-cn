---
category: Reactivity
---

# reactivePick

Reactively pick fields from a reactive object.

响应式地从响应式对象中选择属性。

## Usage

```js
import { reactivePick } from '@vueuse/core'

const obj = reactive({
  x: 0,
  y: 0,
  elementX: 0,
  elementY: 0,
})

const picked = reactivePick(obj, 'x', 'elementX') // { x: number, elementX: number }
```

### Scenarios 使用场景

#### Selectively passing props to child 选择性地给子组件传参

```html
<script setup>
import { reactivePick } from '@vueuse/core'

const props = defineProps({
  value: {
    default: 'value',
  },
  color: {
    type: String,
  },
  font: {
    type: String,
  }
})

const childProps = reactivePick(props, 'color', 'font')
</script>

<template>
  <div>
    <!-- only passes "color" and "font" props to child -->
    <ChildComp v-bind="childProps" />
  </div>
</template>
```

#### Selectively wrap reactive object

Instead of doing this

```ts
import { reactive } from 'vue'
import { useElementBounding } from '@vueuse/core'

const { height, width } = useElementBounding() // object of refs
const size = reactive({ height, width })
```

Now we can just have this

```ts
import { reactivePick, useElementBounding } from '@vueuse/core'

const size = reactivePick(useElementBounding(), 'height', 'width')
```
