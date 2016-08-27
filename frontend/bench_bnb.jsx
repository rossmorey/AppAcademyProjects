import React from 'react';
import ReactDOM from 'react-dom';
import { configureStore } from './store/store.js';
import * as ACTIONS from './actions/bench_actions';
import { fetchBenches } from './util/bench_api_util';

window.requestBenches = ACTIONS.requestBenches;
window.fetchBenches = fetchBenches;

document.addEventListener('DOMContentLoaded', () => {
  const store = window.Store = configureStore();
  const root = document.getElementById('root');
  // ReactDOM.render(<div store={store} />, root);
});
