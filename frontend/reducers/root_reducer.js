import {combineReducers} from 'redux';
import BenchesReducer from './benches_reducer';

const RootReducer = combineReducers({
  benches: BenchesReducer
});

export default RootReducer;
