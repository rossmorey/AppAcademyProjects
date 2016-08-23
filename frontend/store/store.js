import { createStore } from 'redux';
import reducer from '../reducers/index.js';

const configureStore = () => createStore(reducer);

export default configureStore;
