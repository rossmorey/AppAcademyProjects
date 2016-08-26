import React from 'react';
import { withRouter } from 'react-router';

class PokemonIndexItem extends React.Component {

  handleClick (router, id) {
    router.push(`/pokemon/${id}`);
  }

  render() {
    const { pokemon, router } = this.props;
    return (
      <li onClick={this.handleClick.bind(this, router, pokemon.id)} className="pokemon-index-item">
        {pokemon.id}
        <img src={pokemon.image_url} />
        {pokemon.name}
      </li>
    );
  }
}

export default withRouter(PokemonIndexItem);
