<!-- CustomInput.vue -->
<template>
    <div>
      <input
        v-if="type === 'text' || type === 'number'"
        :type="type"
        class="form-control"
        :value="modelValue"
        @input="$emit('update:modelValue', $event.target.value)"
      />
      <select  class="form-select" v-if="type === 'select'" :value="modelValue" @change="$emit('update:modelValue', $event.target.value)">
        <option v-for="option in options" :value="option.value" :key="option.value">{{ option.text }}</option>
      </select>
    </div>
  </template>
  
  <script>
  export default {
    props: ['modelValue', 'type', 'options'],
    emits: ['update:modelValue']
  };
  </script>
  