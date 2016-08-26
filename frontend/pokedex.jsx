import React from 'react';
import ReactDOM from 'react-dom';
import * as API from './util/api_util';
import * as ACTIONS from './actions/pokemon_actions';
import configureStore from './store/store';
import Root from './components/root.jsx';

document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore();
  const root = document.getElementById('root');
  ReactDOM.render(<Root store={store} />, root);
});
