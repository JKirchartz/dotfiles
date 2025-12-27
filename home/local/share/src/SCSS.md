SCSS
=====

When using react's css module imports use `:global` inline with the classnames to prevent it from having a UUID appended to the name.

```
.element {
    color: black;

    :global .subclass {
        color: green;

    }
}
```
