<template>
  <div>
    <p><router-link to="/">Back</router-link></p>
    <table class="table">
      <thead>
        <tr>
          <th>Day</th>
          <th>Weight</th>
        </tr>
      </thead>

      <tbody>
        <tr v-for="entry in entries" class="weight-entry">
          <td>{{ entry.day ? entry.day : 'No date' | humanize }}</td>
          <td>{{ entry.value }} lbs</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
 import axios from 'axios'
 import moment from 'moment'

 export default {
   data () {
     return {
       entries: [],
     }
   },

   mounted () {
     axios
       .get("/weight_entries.json")
       .then(resp => {
         this.entries = resp.data || {}
       })
   },

   filters: {
     humanize: (dateStr) => {
       return moment(dateStr).fromNow()
     }
   },
 }
</script>

<style scoped>
 p {
     font-size: 2em;
     text-align: center;
 }
</style>
