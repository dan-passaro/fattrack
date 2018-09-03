<template>
  <div id='app'>
    <p>Vue message: {{ message }}</p>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
        message: "Hello world!"
      }
    }
  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
