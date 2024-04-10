### Prerequisites:

Function runs on `ruby2.1.5`

### Environment variables:

Change the versions depending on the new release version and the current release version.

```shell
export CURRENT_VERSION=10.6.3
export NEW_VERSION=10.6.4

```

### Steps to create a new documentation for new version:

In the root directory of this repository:

1. Run the following command to create a new documentation:

```shell
ruby util/versionize-rl10-docs.rb $CURRENT_VERSION $NEW_VERSION
```

This will create a new branch with a release version naming from master branch.

2. Make these manual changes (reference https://github.com/rightscale/docs/pull/1369 )

- #### a. In previous version, remove these lines on all files

-# IMPORTANT: 'alias:' metadata line MUST ONLY BE in LATEST REV, requiring removal of 'alias:' line upon a new latest doc directory revision
-alias: [rl/reference/index.html, rl10/reference/index.html]

```shell
sed -i -e '/alias:/d' source/rl10/reference/${CURRENT_VERSION}/*
```

This will remove the lines in the `$CURRENT_VERSION` reference.

- #### b. In the 10.6.3 reference dirs there's a few places where it's changed to 10.6.4 instead. For consistency, 10.6.2 docs should point to 10.6.2 versions, 10.6.3 docs should point to 10.6.3 versions. So `$CURRENT_VERSION` should point to `$CURRENT_VERSION`

```shell
grep ${NEW_VERSION} source/rl10/reference/${CURRENT_VERSION}/\*
```

```shell
sed -i -e 's+/rll/10.6.4+/rll/10.6.3+g' _
```

```shell
rm \_.md-e
```

- #### c. `../releases/rl10_10.5.1_release.html` needs to change to `../../releases/rl10_10.5.1_release.html` in `rl10_os_compatibility.html.md` for all versions

3. Manually update:

`source/rl10/releases/index.html.md`

4. Create new release file:

```shell
touch source/rl10/releases/rl10_${NEW_VERSION}_release.html.md
```
