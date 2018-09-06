<template>
  <div class="row">
    <div class="text-center col-xs-12 col-md-6 col-md-offset-3">
      <h2 class="h3">Your weight for today:</h2>

      <div
        v-if="!entry.created"
        key="enter-value"
      >
        <div class="text-center col-xs-12 col-md-6 col-md-offset-3">
          <p>
            <input
              class="form-control"
              v-model="entry.value"
            >
          </p>
        </div>

        <div class="text-center col-xs-12 col-md-6 col-md-offset-3">
          <p>
            <input
              class="btn btn-primary"
              value="Submit"
              @click="update()"
            >
          </p>
        </div>
      </div>

      <div
        v-else
        key="show-value"
      >
        <p>{{ entry.value }}</p>
      </div>
    </div>
  </div>
</template>

<script>
 import axios from 'axios'

 export default {
   data () {
     return {
       entry: {}
     }
   },

   mounted () {
     axios
       .get("/weight_entries/today.json")
       .then(resp => {
         this.entry = resp.data || {}
       })
   },

   methods: {
     update () {
       axios
         .put("/weight_entries/today.json", this.entry)
         .then(resp => {
           console.log('Got a response:', resp)
           this.entry = resp.data || {}
         })
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
