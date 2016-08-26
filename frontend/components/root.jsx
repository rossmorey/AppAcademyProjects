import React from 'react';
import PokemonIndexContainer from './pokemon/pokemon_index_container';
import { Provider } from 'react-redux';
import { Router, Route, hashHistory } from 'react-router';
import { requestAllPokemon, requestPokemon } from '../actions/pokemon_actions';
import PokemonDetailContainer from './detail/pokemon_detail_container';

class Root extends React.Component {

  render () {
    const { store } = this.props;
    const getAllPokemon = () => {
      store.dispatch(requestAllPokemon());
    };

    const getSinglePokemon = (nextState) => {
      store.dispatch(requestPokemon(nextState.params.id));
    };
    return (
      <Provider store={store}>
        <Router history={hashHistory}>
          <Route path="/" component={PokemonIndexContainer} onEnter={getAllPokemon}>
            <Route path="/pokemon/:id" component={PokemonDetailContainer} onEnter={getSinglePokemon} />
          </Route>
        </Router>
      </Provider>
    );
  }
}

export default Root;
