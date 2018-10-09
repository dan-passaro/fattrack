<style scoped>
 table {
     background-color: blue;
     bgcolor: blue;
 }
</style>

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
        <tr v-for="entry in entries" class="weight-entry show-on-hover-container">
          <td :title="entry.day">{{ entry.day ? entry.day : 'No date' | humanize }}</td>
          <td>
            {{ entry.value }} lbs
            <span class="show-on-hover">
              <a href="#" @click.prevent="editEntry(entry)">
                <span class="glyphicon glyphicon-pencil"></span>
              </a>
              <a href="#" @click.prevent="deleteEntry(entry)">
                <span class="glyphicon glyphicon-remove"></span>
              </a>
            </span>
          </td>
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

   methods: {
     editEntry(entry) {
       console.log('Editing: ', entry)
     },

     deleteEntry(entry) {
       console.log('Deleting: ', entry)
     },
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
