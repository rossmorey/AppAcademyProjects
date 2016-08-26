import { createStore, applyMiddleware } from 'redux';
import { PokemonReducer } from '../reducers/pokemon_reducer';
import PokemonMiddleware from '../middleware/pokemon_middleware';

const MasterMiddleware = applyMiddleware(PokemonMiddleware);
// window.createStore = createStore;
// window.MasterMiddleware = MasterMiddleware;
// window.PokemonReducer = PokemonReducer;

const configureStore = () => (createStore(
    PokemonReducer,
    MasterMiddleware
  ));

export default configureStore;
