# SSP Labs
System Software Practice Labs

### 1. First Lab:

#### Description
 Program for analyze folders and what its contents.\
 It make <em><strong>.xls</strong></em> file with table

 It give you:
<ol>
<li>File names</li>
<li>File sizes (human readable)</li>
<li>Files extensions</li>
<li>File editing data</li>
<li>Video duration for correct file</li>
<li>Music duration for correct file(Min)</li>
</ol>

#### How to use it
It works with special symbols in name files and folders. It find files recursively.\
Just run it :sunglasses::
```bash
./fileAnalyzer.sh <folder_name> <output_file.xls>
```
### 2. Second Lab

#### Description
  Program for installing [<em><strong>go-ipfs</strong></em>][https://github.com/ipfs/go-ipfs] on Ubuntu.
  For manual installation use original guide.

  Current script add new apt repository and install(If necessary) update go-lang and install go-ipfs in home repository.

#### How to use it
  If you want to run go-ipfs, do :
  ```bash
  cd ~/go/bin
  ./ipfs init
  ```
