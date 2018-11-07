<template>
  <div>
    <div class="row">
      <div class="text-center col-xs-12 col-md-6 col-md-offset-3">
        <h2 class="h3">Your weight for today:</h2>

        <div
          v-if="editing"
          key="enter-value"
        >
          <form @submit.prevent="update">
            <div class="text-center col-xs-12 col-md-6 col-md-offset-3">
              <p>
                <input
                  class="form-control"
                  ref="input"
                  type="number"
                  v-model="entry.value"
                  @blur="cancelEdit"
                >
              </p>
            </div>

            <div class="text-center col-xs-12 col-md-6 col-md-offset-3">
              <p>
                <input
                  type="submit"
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
    <p><router-link to="/weight-entries">See old entries</router-link></p>
    <!-- <p><a href="/weight_entries">See old entries</a></p> -->
  </div>
</template>

<script>
 import axios from 'axios'

 export default {
   data () {
     return {
       entry: {},
       editing: false,
       originalValue: null,
     }
   },

   mounted () {
     axios
       .get("/weight_entries/today")
       .then(resp => {
         this.entry = resp.data || {}
         if (this.entry.value) {
           this.originalValue = this.entry.value
         } else {
           this.editEntryBegin()
         }
       })
   },

   methods: {
     update () {
       axios
         .put("/weight_entries/today", this.entry)
         .then(resp => {
           this.entry = resp.data || {}
           this.editing = false
           this.originalValue = this.entry.value
         })
     },

     cancelEdit () {

       // Can't cancel if there's no entry for today.
       if (!this.originalValue) {
         return
       }

       this.editing = false
       this.entry.value = this.originalValue
     },

     editEntryBegin () {
       this.editing = true
       this.$nextTick(() => this.$refs.input.focus())
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
