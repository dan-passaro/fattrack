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
        <old-entry-row
          v-for="entry in entries"
          :entry="entry"
          @on-delete="onDelete"
        />
      </tbody>
    </table>
  </div>
</template>

<script>
 import axios from 'axios'

 import OldEntryRow from './old-entry-row.vue'

 export default {
   components: {
     OldEntryRow,
   },

   data () {
     return {
       entries: [],
     }
   },

   methods: {
     onDelete (entry) {
       axios
         .delete("/weight_entries/" + entry.id)
         .then(() => {
           let i = this.entries.indexOf(entry)
           if (i >= 0) {
             this.entries.splice(i, 1)
           } else {

             // This should never happen
             console.log('Deleted entry not found...?')
           }
         })
     },
   },

   mounted () {
     axios
       .get("/weight_entries.json")
       .then(resp => {
         this.entries = resp.data || {}
       })
   },

 }
</script>
