App.CategoriesListView = Em.CollectionView.extend
  itemViewClass: 'App.CategoryView'
  tagName: 'ul'
  classNameBindings: [':nav', ':nav-tabs']

App.CategoryView = Em.View.extend
  template: Em.TEMPLATES['categories/category']