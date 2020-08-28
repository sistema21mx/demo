<template>
  <v-container>


    <v-card
      color="transparent"
      >
      <v-img
        class="white--text align-end"
        :height="height"
        :src="require('../../assets/argo.png')"
        >
        <v-card
          class="d-flex flex-row-reverse align-end mb-6"
          color="transparent"
          tile
          >

          <v-flex xs6 sm3 md3>

            <v-card
              v-for="n in 1"
              :key="n"
              class="pa-0"
              color="primary"
              
              
              >

          <v-toolbar
                color="primary"
                dense
                :short="short"
                dark 
                @click.stop="collapseOnScroll=!collapseOnScroll">
            <v-toolbar-title v-bind:class="classObject">Ingresar al Sistema</v-toolbar-title>
            
          </v-toolbar>





            </v-card>
          </v-flex>

        </v-card>
      </v-img>
    </v-card>


  <v-form>
    <v-container>
      <v-row>

        <v-col cols="6" sm="6">
              <v-text-field
                id="email"
                label="Email"
                name="email"
                append-icon="person"
                type="text"
                :hint="`${hintEmail}`"
                v-model="logDetails.email"
                v-on:keyup="keymonitor"
                dense
                filled
                clearable
                persistent-hint
              ></v-text-field>
        </v-col>

        <v-col cols="6" sm="6">
              <v-text-field
                id="password"
                label="Password"
                name="password"
                v-model="logDetails.password" 
                v-on:keyup="keymonitor"
                append-outer-icon="lock"
                :append-icon="showPass ? 'mdi-eye' : 'mdi-eye-off'"
                :type="showPass ? 'password' : 'password'"
                :hint="`${hintPass}`"
                filled
                persistent-hint
                @click:append="showPass = !showPass"
              ></v-text-field>
        </v-col>

      </v-row>
    </v-container>
  </v-form>



  </v-container>
</template>

<script>
// import {mixshared} from '@/mixins/mixshared.js'

export default {
  name: '',
  // mixins: [mixshared],
  // props: [''],
  components: {
    //
  },
  data: () => ({
    //
    height: '0%',
    hintEmail: '',
    hintPass: '',
    showPass: false,
    short: true,
    collapseOnScroll: false,
    first: 'John',
    last: 'Doe',
    logDetails: {
      email: '', 
      password: '',
      evento: ''
    },


  }),
  methods: {
    start: function () {
      //
      alert('start')
    },
    keymonitor: function (event) {
      if (event.key === 'Enter' && this.btnLoad === false) {
        this.checkLogin()
      }
    },
    processData: function () {
      //
    }
  },
  created () {
    //
  },
  mounted () {
    if(Number(this.loggedIn)===1){
      this.height='80%'
    }
    if(Number(this.loggedIn)===0){
      this.height='60%'
    }
  },
  updated () {
    //
    if(Number(this.loggedIn)===1){
      this.height='80%'
    }
    if(Number(this.loggedIn)===0){
      this.height='60%'
    }
  },
  watch: {
    //
  },
  computed: {
    loggedIn () {
      return this.$store.getters.getLoggedIn
    },
    classObject: function () {
      return {
        'headline': this.imageHeight === 'sm' ? true : false,
        'body-2': this.imageHeight !== 'sm' ? true : false,
      }
    }
  }
}
</script>