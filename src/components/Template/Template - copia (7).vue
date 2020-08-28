<template>
  <v-container>





<div class="background" id="app">
  <div class="cover">
    <div class="leftDiv">
      <div>
        <div v-if="errors.length">
          <ul style="list-style: none; color: red; text-align: center; background-color: rgba(0,0,0,0.3)">
              
              <li v-for="error in errors" :key="error">{{ error }}</li>
            </ul>
          </div>
        <v-tabs color="transparent" dark slider-color="yellow">
          <v-tab style="background-color: rgba(0,0,0,0.5); width: 50%">
            Login
          </v-tab>

          <v-tab style="background-color: rgba(0,0,0,0.5); width: 50%">
            Register
          </v-tab>
          <v-tab-item>
            <v-card flat>
              <v-card-text>
                <form method="post" action="#" @submit="checkLogin" novalidate="true">
                  <div style="text-align: center">Welcome back, Login</div>

                  <label>
                      <input v-model="phoneEmail" class="input" type="text" placeholder="Phone or Email" />
                    </label>

                  <label>
                      <input v-model="password" class="input" type="password" placeholder="Password" />
                    </label>
                  <a href="#" class="forgot-pass">Forgot password?</a>
                  <button type="submit" class="submit button">Sign In</button>
                </form>
              </v-card-text>
            </v-card>
          </v-tab-item>

          <v-tab-item>
            <v-card flat>
              <v-card-text>
                <form method="post" action="#" @submit="checkForm" novalidate="true">
                  <div style="text-align: center">New here? Register</div>

                  <label>
                      <input v-model="fName" class="input" type="text" placeholder="First Name" />
                    </label>

                  <label>
                      <input v-model="lName" class="input" type="text" placeholder="Last Name" />
                    </label>

                  <label>
                      <input v-model="email" class="input" type="email" placeholder="Email" />
                    </label>

                  <label>
                      <input v-model="phone" class="input" type="tel" pattern="\d\d\d\d\d\d\d\d\d\d\d" placeholder="Phone" />
                    </label>

                  <label>
                      <input v-dodel="rpassword" class="input" type="password" placeholder="Password" />
                    </label>

                  <button type="submit" class="submit button">Sign Up</button>
                </form>
              </v-card-text>
            </v-card>
          </v-tab-item>

        </v-tabs>
      </div>
    </div>
  </div>
</div>




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
                errors: [],
                phoneEmail: null,
                password: null,
                fName: null,
                lName: null,
                email: null,
                phone: null,
                rpassword: null,


  }),
  methods: {
    initialize: function () {
      //
    },


             checkLogin: function (e) {
             this.errors = [];

                if (!this.phoneEmail) {
                  this.errors.push("Entre your email or phone number.");
                }

                if (!this.password) {
                  this.errors.push("Your password is required");
                }
               
              if (!this.errors.length) {
                return true;
              }

              e.preventDefault();

           },
           
            checkForm: function (e) {
              
              if (!this.fName) {
                this.errors.push("What's your first name?");
              }
              
              if (!this.lName) {
                this.errors.push("What's your last name?");
              }
              
              if (!this.email) {
                this.errors.push('Entre your email address.');
              } else if (!this.validEmail(this.email)) {
                this.errors.push('Your email address is not correct');
              }
              
              if (!this.phone) {
                this.errors.push("What's your phone number");
              }

              if (!this.rpassword) {
                this.errors.push("Please entre a plassword.");
              }

              if (!this.errors.length) {
                return true;
              }

              e.preventDefault();
            },
              
            validEmail: function (email) {
              return email;
            },



    processData: function () {
      //
    }
  },
  created () {
    //
  },
  mounted () {
    //
  },
  updated () {
    //
  },
  watch: {
    //
  },
  computed: {
    //
  }
}
</script>

<style scoped>
.inputLogin {
    background-color: rgba(0, 0, 0, 0.5);
    display: block;
    width: 100%;
    height: 50px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    border-bottom: solid 2px black;
    box-shadow: 0 0 5px rgb(0, 0, 0);
    margin: 20px 0 30px 0;
    padding: 10px;
    color: white;
}

.inputLogin:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px rgba(0, 0, 0, 0.5) inset;
}



.background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: url("../../assets/argo.png");
    background-repeat: no-repeat;
    background-color: transparent;
    /* background-size: cover; */
}
.cover {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow-y: auto;
    overflow-x: hidden;
    background-color: rgba(0, 0, 0, 0.5);
}

.leftDiv {
    position: absolute;
    top: 0;
    right: 0;
    padding: 110px 30px 50px 30px;
    width: auto;
    min-height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    color: white;
    box-sizing: border-box;
}

.input {
    background-color: rgba(0, 0, 0, 0.5);
    display: block;
    width: 100%;
    height: 50px;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    border-bottom: solid 2px black;
    box-shadow: 0 0 2px rgba(255, 255, 255, 0.76);
    margin: 20px 0 30px 0;
    padding: 10px;
}

.input:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px rgba(0, 0, 0, 0.5) inset;
}

.forgot-pass{
  display: block;
  margin: 10px;
  color: #ffffff;
  text-decoration: none;
  text-align: center;
}

.submit {
    margin-top: 20px;
    margin-bottom: 20px;
    color: #FFFFFF;
    background: red;
    text-transform: uppercase;
}

.button {
    display: block;
    margin: 0 auto;
    width: 260px;
    height: 36px;
    border-radius: 30px;
    font-size: 15px;
    cursor: pointer;
}
</style>