import { mount } from '@vue/test-utils'
import Tab1Page from '@/views/Tab1Page.vue'

describe('Tab1Page.vue', () => {
  it('renders home page', () => {
    const wrapper = mount(Tab1Page)
    expect(wrapper.text()).toMatch('Accueil de l\'application')
  })
})
