import React from 'react';
import PokemonIndexItem from './pokemon_index_item';


class PokemonIndex extends React.Component {


  render () {
    // debugger
    const pokemons = this.props.pokemon.map((pokemon) => {
      return (
        <PokemonIndexItem key={pokemon.name + pokemon.id.toString()} pokemon={pokemon}/>
        );
    });
    return (
      <section className="pokedex">
        <ul>
        {pokemons}
      </ul>
      {this.props.children}
    </section>
    );
  }
}

export default PokemonIndex;
