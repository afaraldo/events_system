module.exports = {
  content: [
    './node_modules/flowbite/**/*.js',
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
  ],
  theme: {
    extend: {
      colors: {
        'primary': '#3490dc',
        'secondary': '#ffed4a',
        'danger': '#e3342f',
      },
      fontFamily: {
        sans: ['Inter var', 'Inter', 'Arial', 'sans-serif'],
      },
      container: {
        center: true,
        padding: '1rem',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require('flowbite/plugin')
  ]
}
