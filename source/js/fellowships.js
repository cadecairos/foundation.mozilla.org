/* eslint no-unused-vars: ["error", { "varsIgnorePattern": "React" }] */

import React from 'react';
import ReactDOM from 'react-dom';

import Person from './components/people/person.jsx';

function getFellows(type = ``, callback) {
  let req = new XMLHttpRequest();

  req.addEventListener(`load`, () => {
    callback.call(this, JSON.parse(req.response));
  });

  // TODO:FIXME: fix this hardcoded url once this endpoint is available on Pulse API staging and production
  req.open(`GET`, `http://test.example.com:8000/api/pulse/profiles/search/?profile_type=fellow&program_type=${type} fellow`);
  req.send();
}

function processFellowData(fellow) {
  let links = {};

  if ( fellow.twitter ) {
    links.twitter = fellow.twitter;
  }

  if ( fellow.linkedin ) {
    links.linkedIn = fellow.linkedin;
  }

  let metadata = {
    'internet_health_issues': fellow.issues,
    links: links,
    name: fellow.custom_name,
    role: `${fellow.program_type}${fellow.program_year ? `, ${fellow.program_year}` : ``}`,
    image: fellow.thumbnail,
    affiliations: [ fellow.affiliation ],
    'custom_link': { text: `See work`, link: `/fellowships/directory` }
  };

  return <Person metadata={metadata} key={fellow.custom_name} />;
}

function renderFellowsSection(type = ``) {
  getFellows(type, fellows => {
    console.log(`fellows`, fellows);

    ReactDOM.render(fellows.map(processFellowData), document.querySelector(`#view-fellows-directory .featured-fellow[data-type='${type}']`));
  });
}

// Embed various Fellowships pages related React components
function injectReactComponents() {
  // Science Fellowship
  if (document.getElementById(`featured-science-fellow`)) {
    let metadata = {
      featured: true,
      'internet_health_issues': [ `Decentralization`, `Open Innovation` ],
      links: [],
      name: `Firstname Surname`,
      role: `[Area Fellowship] Fellow, [Year]`,
      location: `City, Country`,
      image: `https://images.pexels.com/photos/264206/pexels-photo-264206.jpeg?w=500`,
      quote: `Quote quote quote quote quote quote quote quote quote quote quote quote.`,
      affiliations: [`Stanford University Professor; YouthLAB founder`],
      'custom_link': { text: `See all science fellows`, link: `/fellowships/directory` }
    };

    ReactDOM.render(<Person metadata={metadata} />, document.getElementById(`featured-science-fellow`));
  }

  // Open Web Fellowship
  if (document.getElementById(`featured-open-web-fellow`)) {
    let metadata = {
      featured: true,
      'internet_health_issues': [ `Decentralization`, `Open Innovation` ],
      links: [],
      name: `Firstname Surname`,
      role: `[Area Fellowship] Fellow, [Year]`,
      location: `City, Country`,
      image: `https://images.pexels.com/photos/802112/pexels-photo-802112.jpeg?w=500`,
      quote: `Quote quote quote quote quote quote quote quote quote quote quote quote.`,
      affiliations: [`Stanford University Professor; YouthLAB founder`],
      'custom_link': { text: `See all science fellows`, link: `/fellowships/directory` }
    };

    ReactDOM.render(<Person metadata={metadata} />, document.getElementById(`featured-open-web-fellow`));
  }

  // Featured fellow on Support page
  if (document.getElementById(`featured-fellow-support-page`)) {
    let metadata = {
      featured: true,
      'internet_health_issues': [ `Decentralization`, `Open Innovation` ],
      links: [],
      name: `Firstname Surname`,
      role: `[Area Fellowship] Fellow, [Year]`,
      location: `City, Country`,
      image: `https://static.pexels.com/photos/416138/pexels-photo-416138.jpeg?w=500`,
      quote: `Quote quote quote quote quote quote quote quote quote quote quote quote.`,
      affiliations: [ `Stanford University Professor; YouthLAB founder`],
      'custom_link': { text: `See all science fellows`, link: `/fellowships/directory` }
    };

    ReactDOM.render(<Person metadata={metadata} />, document.getElementById(`featured-fellow-support-page`));
  }

  // Fellows on Fellows Directory page
  if (document.querySelectorAll(`#view-fellows-directory .featured-fellow`)) {
    let sections = document.querySelectorAll(`#view-fellows-directory .featured-fellow`);

    sections.forEach(section => {
      renderFellowsSection(section.dataset.type);
    });
  }
}

export default { injectReactComponents };
