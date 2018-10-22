<template>
  <tr class="weight-entry show-on-hover-container">
    <td :title="entry.day">{{ entry.day ? entry.day : 'No date' | humanize }}</td>
    <td>
      <span v-if="editing" key="edit-value">
        <form
          @submit.prevent="update"
          class="form-inline"
        >
          <div class="col-xs-4">
            <input
              ref="input"
              v-model="entry.value"
              @blur="stopEditing"
              class="form-control"
            >
          </div>
          <button class="btn btn-primary col">Save</button>
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
       originalValue: null,
     }
   },

   mounted () {
     this.originalValue = this.entry.value
   },

   methods: {
     editEntry(entry) {
       this.editing = true
       this.$nextTick(() => this.$refs.input.focus())
     },

     deleteEntry(entry) {
       this.$emit('on-delete', this.entry)
     },

     update () {
       axios
         .put("/weight_entries/" + this.entry.id, this.entry)
         .catch(err => {
           console.log('Got an error: ', err)
         })
       this.originalValue = this.entry.value
       this.editing = false
     },

     stopEditing () {
       this.editing = false
       this.entry.value = this.originalValue
     },
   },

   filters: {
     humanize: (dateStr) => {
       return moment(dateStr).calendar(null, {
         sameDay: '[Today]',
         lastDay: '[Yesterday]',
         lastWeek: 'dddd',
         sameElse: 'MMM[.] Do',
       })
     }
   },
 }
</script>
