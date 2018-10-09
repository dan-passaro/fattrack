<template>
  <tr class="weight-entry show-on-hover-container">
    <td :title="entry.day">{{ entry.day ? entry.day : 'No date' | humanize }}</td>
    <td>
      <span v-if="editing" key="edit-value">
        <form @submit.prevent="update">
          <input class="form-control" v-model="entry.value">
          <button class="btn btn-primary">Ayy</button>
        </form>
      </span>
      <span v-else key="show-value">
        {{ entry.value }} lbs
        <span class="show-on-hover">
          <a href="#" @click.prevent="editEntry">
            <span class="glyphicon glyphicon-pencil"></span>
          </a>
          <a href="#" @click.prevent="deleteEntry">
            <span class="glyphicon glyphicon-remove"></span>
          </a>
        </span>
      </span>
    </td>
  </tr>
</template>

<script>
 import axios from 'axios'
 import moment from 'moment'

 export default {
   props: ['entry'],

   data () {
     return {
       editing: false,
     }
   },

   methods: {
     editEntry(entry) {
       console.log('Editing: ', entry)
       this.editing = true
     },

     deleteEntry(entry) {
       console.log('Deleting: ', entry)
       axios
              .delete("/weight_entries/" + this.entry.id)
              .then(() => console.log('Deleted'))
     },

     update () {
       axios
         .put("/weight_entries/" + this.entry.id, this.entry)
         .then(resp => {
           console.log('Update complete')
         })
         .catch(err => {
           console.log('Got an error: ', err)
         })
       this.editing = false
     }
   },

   filters: {
     humanize: (dateStr) => {
       return moment(dateStr).fromNow()
     }
   },
 }
</script>
