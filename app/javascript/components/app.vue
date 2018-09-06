<template>
  <div class="row">
    <div class="text-center col-xs-12 col-md-6 col-md-offset-3">
      <h2 class="h3">Your weight for today:</h2>

      <div
        v-if="isEditing"
        key="enter-value"
      >
        <form @submit="update">
          <div class="text-center col-xs-12 col-md-6 col-md-offset-3">
            <p>
              <input
                class="form-control"
                name="fizz"
                v-model="entry.value"
              >
            </p>
          </div>

          <div class="text-center col-xs-12 col-md-6 col-md-offset-3">
            <p>
              <input
                @click="update"
                class="btn btn-primary"
                value="Submit"
              >
            </p>
          </div>
        </form>
      </div>

      <div
        v-else
        class="text-center col-xs-12 col-md-6 col-md-offset-3"
        key="show-value"
      >
        <h2 class="h3">
          {{ entry.value }} lbs
          <a href="#" @click="editEntryBegin">
            <span class="glyphicon glyphicon-pencil"></span>
          </a>
        </h2>
      </div>
    </div>
  </div>
</template>

<script>
 import axios from 'axios'

 export default {
   data () {
     return {
       entry: {},
       editing: false,
     }
   },

   computed: {
     isEditing () {
       return !this.entry.value || this.editing
     }
   },

   mounted () {
     axios
       .get("/weight_entries/today")
       .then(resp => {
         this.entry = resp.data || {}
       })
   },

   methods: {
     update () {
       axios
         .put("/weight_entries/today", this.entry)
         .then(resp => {
           this.entry = resp.data || {}
           this.editing = false
         })
     },

     editEntryBegin () {
       this.editing = true
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
