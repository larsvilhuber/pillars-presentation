# Tutorial

## Follow along


## To set this up

You may need an `.Renviron` file in the root of the project with the following content:

```
QUALTRICS_API_KEY='something here'
QUALTRICS_BASE_URL='XXXX.qualtrics.com'
DATAVERSE_TOKEN='somethingelse'
DATAVERSE_SERVER='https://demo.dataverse.org'
DATAVERSE_DATASET_DOI='doi:10.70122/xxx/xxxxx'
```

where you should replace this with the true values. See the [Qualtrics API documentation](https://www.qualtrics.com/support/integrations/api-integration/overview/) for more information. For Dataverse uploader, see <https://github.com/IQSS/dataverse-uploader>.

You should then set the GH Actions secrets with

```
gh secret set -f .Renviron
```

If you need to work in Codespaces, you will also need to add this to your Codespace secrets:

```
gh secret set -f .Renviron --user $GITHUB_REPOSITORY
```

then go to <https://github.com/settings/codespaces> and enable them for this repository (if not already done).

## Github Actions workflow

The following is approximately the workflow:

![workflow](./images/workflow.png)
