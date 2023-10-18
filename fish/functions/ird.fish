function ird --wraps='pnpm i webpack webpack-cli webpack-dev-server @swc/core @swc/cli swc-loader -D;pnpm i react react-dom' --wraps='pnpm i webpack webpack-cli webpack-dev-server @swc/core @swc/cli swc-loader css-loader sass-loader style-loader -D;pnpm i react react-dom' --description 'alias ird=pnpm i webpack webpack-cli webpack-dev-server @swc/core @swc/cli swc-loader css-loader sass-loader style-loader -D;pnpm i react react-dom'
  pnpm i webpack webpack-cli webpack-dev-server @swc/core @swc/cli swc-loader css-loader sass-loader style-loader -D;pnpm i react react-dom $argv; 
end
