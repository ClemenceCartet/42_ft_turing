FROM haskell

WORKDIR /dev/turing

RUN cabal update

ENTRYPOINT [ "sh" ]
CMD [ "./container_script.sh" ]