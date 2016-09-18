import React from 'react';
import ReactDOM from 'react-dom';
import $ from 'jquery';
import Note from './util/note.js';
import configureStore from './store/store.js';
import Root from './components/root.jsx';

$(function() {
  const store = configureStore();
  ReactDOM.render(<Root store={store} />, document.getElementById('root'));
});
