<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title>En cours v2</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content :fullscreen="true">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">En cours v2</ion-title>
        </ion-toolbar>
      </ion-header>
      
      <ExploreContainer name="Game en cours" :personns="state.personns" :plateform="state.plateform"/>
    </ion-content>
  </ion-page>
</template>

<script setup lang="ts">
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent } from '@ionic/vue';
import ExploreContainer from '@/components/ExploreContainer.vue';

import { getPlatforms } from '@ionic/vue';
import { computed, reactive } from 'vue';

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
        name: 'Jane',
        age: 21,
        status: "En cours"
      }
    ]
  }
);

</script>
