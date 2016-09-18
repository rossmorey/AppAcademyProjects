import { BenchConstants } from '../actions/bench_actions';

const BenchesReducer = (state = {}, action) => {
  debugger
    switch(action.type){
    case BenchConstants.RECEIVE_BENCHES:
      return action.benches;
    default:
      return state;
  }
};

export default BenchesReducer;
