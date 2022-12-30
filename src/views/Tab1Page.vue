<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title>Accueil v2</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Accueil v2</ion-title>
        </ion-toolbar>
      </ion-header>
      <ExploreContainer name="Accueil de l'application" :personns="state.personns" :plateform="state.plateform"/>
      <ion-card>
        <ion-card-header>
          <ion-card-title>
            <p v-if="state.plateform.includes('mobile')">Vous êtes sur un téléphone</p>
            <p v-else>Vous êtes sur un ordinateur</p>
          </ion-card-title>
        </ion-card-header>
        <ion-card-content>
          <p>Test de variable: {{ testVariable }}</p>
        </ion-card-content>
      </ion-card>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonCard, IonCardHeader, IonCardTitle, IonCardContent } from '@ionic/vue';
import ExploreContainer from '@/components/ExploreContainer.vue';

import { getPlatforms } from '@ionic/vue';
import { computed, reactive } from 'vue';

const testVariable = process.env.VUE_APP_TEST_VARIABLE;

const plateform  = computed(() => {
  return getPlatforms();
});

const state = reactive<
  {
    plateform: ("mobile" | "ios" | "ipad" | "iphone" | "android" | "phablet" | "tablet" | "cordova" | "capacitor" | "electron" | "pwa" | "mobileweb" | "desktop" | "hybrid")[];
    isMobile: boolean;
    personns: {
      name: string;
      age: number;
      status: "En attente" | "En cours" | "Terminé"
    }[];
  }
>(
  {
    plateform: plateform.value,
    isMobile: false,
    personns: [
      {
        name: 'John',
        age: 20,
        status: "En attente"
      },
      {
        name: 'Jane',
        age: 21,
        status: "En cours"
      },
      {
        name: 'Jack',
        age: 22,
        status: "Terminé"
      }
    ]
  }
);
</script>

<style scoped>
ion-card {
  margin: 2em;
}
ion-card-header {
  text-align: center;
}
</style>
