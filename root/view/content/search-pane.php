<section id="search-pane" class="page-wrap flash">
    <p class="bounceUp">
        <a href="#header-inner" id="up1" title="Go Up" class="back-head">
            <svg class="gridicon gridicons-chevron-down" height="32" width="32" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><g><path d="M20 9l-8 8-8-8 1.414-1.414L12 14.172l6.586-6.586"></path></g></svg>
        </a>
    </p>
    <!-- The following container "engine-values" houses hidden elements storing values of the search engine pane selected by user, to be used by AJAX -->
    <span style="display: none" id="engine-values">
        <input type="hidden" id="search_values"/>   //--------------------------JSON string that consolidates all values
        <input type="hidden" id="accom" value="Any"/>   //----------------------ACCOMMODATION TYPE radion button
        <input type="hidden" id="rooms"/>   //----------------------------------ROOMS checkboxes
        <input type="hidden" id="ptype" value="Any"/>   //----------------------PROPERTY TYPE radio button
        <input type="hidden" id="minP"/>    //----------------------------------MINIMUM PRICE RANGE text box
        <input type="hidden" id="maxP"/>    //----------------------------------MAXIMUM PRICE RANGE text box
        <input type="hidden" id="bed" value=-1 />   //--------------------------BED ROOMS quantity combobox
        <input type="hidden" id="bath" value=-1/>   //--------------------------BATH ROOMS quantity combobox
        <input type="hidden" id="kitch" value=-1/>  //--------------------------KITCHENS quantity combobox
        <input type="hidden" id="bedroom" value="Any"/>   //--------------------BEDROOM type radio button
        <input type="hidden" id="roomgender" value="Any"/> //-------------------BEDROOM GENDER RISTRICTION radio button
        <input type="hidden" id="feat"/>   //-----------------------------------Selected Features string
    </span>
    <?php require_once dirname(__FILE__,3).'/epiqworx/gui/noscript.html';?>
    <div id="searchengine" class="feature js">
        <div id="row-01" class="clearfix">
<!--            <select name="city" id="cmbCity" title="More to be added in future">
                <option>Port Elizabeth</option>
            </select>-->
            <select name="suburb" id="cmbSuburb" title="Don't change for 'Any' Suburb">
                <?php foreach ($suburbs as $row) { ?>
                    <option value=<?= $row['SUBURB_ID']; ?>><?= $row['SUBURB_NAME']; ?></option>
                <?php } ?>    
            </select>
            <input id="btnSearch" value="Find" class="btnMing"type="submit" onclick="search('<?=$del;?>',<?= $page;?>,<?= $records;?>)" onmouseover="prepareStrings('<?=$del;?>')"/></div>
        <div class="sexion">
            <span id="accommodation" class="attribute">
                <h3 onclick="toggleFeature(subAccom)">ACCOMMODATING</h3>
                <div class="sub-attribute" id="subAccom"><hr/>
                    <span class="spacer">
                        <?php foreach ($accom as $value) { ?>
                        <label class="radio-align"><input type="radio" name="accom" value="<?= $value; ?>" required class="rbn" onchange="getValue(this)" <?php if($value === "Any"){ echo 'checked';} ?>/><?= $value; ?></label>
                        <?php } ?>
                    </span>
                </div>
            </span>
            <span id="room" class="attribute">
                <h3 onclick="toggleFeature(subRoom)">ROOMS</h3>
                <div class="sub-attribute" id="subRoom"><hr/>
                    <span class="spacer">
                        <?php foreach ($rooms as $value) { ?><label class="check-align"><input type="checkbox" name="rooms[]" value="<?= $value['ROOM_ID']; ?>" class="chk" onchange="getValues(this.name,'<?=$del;?>')"/> <?= $value['ROOM_TYPE']; ?></label><?php } ?>
                    </span>
                </div>
            </span>
            <span id="propertyType" class="attribute">
                <h3 onclick="toggleFeature(subPtype)">PROPERTY TYPE</h3>
                <div class="sub-attribute" id="subPtype" ><hr/>
                    <span class="spacer">
                        <?php foreach ($PropTypes as $value) { ?>
                        <label class="radio-align"><input type="radio" name="ptype" value="<?= $value['PROP_TYPE_ID']; ?>" required class="rbn" onchange="property(this)"/><?= $value['DESCRIPTION']; ?></label>
                        <?php } ?>
                        <label class="radio-align"><input type="radio" required name="ptype" value="Any" class="rbn" checked onchange="property(this)"/>Any</label>
                    </span>
                </div>
            </span>
            <span id="pricing" class="attribute">
                <h3 onclick="toggleFeature(subPrice)">PRICE RANGE</h3>
                <div class="sub-attribute" id="subPrice" ><hr/>
                    <input type="number" name="maxP" min="100" placeholder="Maximum ( <?= $currency;?> )" class="txt" step="100" onchange="getValue(this)" title="one month rental"/>
                    <input type="number" name="minP" min="100" placeholder="Minimum ( <?= $currency;?> )" class="txt" step="100" onchange="getValue(this)"  title="one month rental"/>
                    <div id="housing-unit-div">
                        <h3>UNIT FEATURES</h3><Br/>
                    <div class="subset" id="div-beds">
                         <select name="bed" title="Don't change for 'Any' number" id="Beds" onchange="minZero(this)">
                            <option value=''selected >Bedrooms :</option>
                            <option value=0>Bachelor</option>
                        <?php for ($K=1;$K<=4;$K++) {?>
                        <option value=<?= $K; ?>><?= "$K+ Beds"; ?></option>
                    <?php }?>
                    </select>
                    </div> 
                    <div class="subset" id="div-baths">
                        <select name="bath"  title="Don't change for 'Any' number" id="Baths"  onchange="minZero(this)">
                            <option value=''selected >Bathrooms :</option>
                        <?php for ($K=1;$K<=5;$K++) {?>
                        <option value=<?= $K; ?>><?= "$K+ Baths"; ?></option>
                    <?php }?>
                    </select>
                    </div>
                    
                    <div class="subset" id="div-kitch">
                        <select name="kitch" title="Don't change for 'Any' number" onchange="minZero(this)">
                            <option value=''selected >Kitchens :</option>
                        <?php for ($K=1;$K<=5;$K++) {?>
                        <option value=<?= $K; ?>><?= "$K+ Kitchens"; ?></option>
                    <?php }?>
                    </select>
                    </div>
                    <div class="subset" id="HUnit">
                        <select name="HUnit" title="Don't change for 'Any' type" id="btype">
                            <option value=''selected >-- Type --</option>
                        <?php foreach ($BuildTypes as $value) {?>
                        <option value=<?= $value['BUILDING_TYPE']; ?>><?= $value['BUILDING_TYPE']; ?></option>
                    <?php }?>
                    </select>
                    </div>
                    </div>
                    <div class="subset bedroom-spec" id="room-setting">
                        <h3>TYPE</h3>
                        <?php foreach ($BedRTypes as $value){?>
                        <label class="radio-align"><input type="radio" name="bedroom" value="<?= $value['BEDROOM_TYPE'];?>" class="rbn" onchange="getValue(this)"/><?= $value['BEDROOM_TYPE'];?></label>
                        <?php }?>
                        <label class="radio-align"><input type="radio" name="bedroom" value="Any" class="rbn" checked="true" onchange="getValue(this)"/>Any</label>
                    </div>
                    <div class="subset bedroom-spec" id="gend-restr">
                        <h3>GENDER</h3>
                        <label class="radio-align"><input type="radio" name="roomgender" value="F" class="rbn"  onchange="getValue(this)"/>Female</label>
                        <label class="radio-align"><input type="radio" name="roomgender" value="M" class="rbn"  onchange="getValue(this)"/>Male</label>
                        <label class="radio-align"><input type="radio" name="roomgender" value="Any" class="rbn" checked="true" onchange="getValue(this)"/>Any</label>
                    </div>
                </div>
            </span>
        </div>
        <div id="facility">
            <h2>FEATURES</h2>
            <div class="sexion">
                <span id="accessory" class="attribute"><h3 onclick="toggleFeature(subAccess)">ACCESSORY</h3>
                    <div class="sub-attribute" id="subAccess"><hr>
                            <span class="spacer">
                                <?php foreach ($accessories as $value) { ?>
                                    <label class="check-align"><input type="checkbox" name="feat[]" value="<?= $value['ITEM_CODE']; ?>" class="chk" onchange="getValues(this.name,'<?=$del;?>')"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
                <span id="furnirure" class="attribute"><h3 onclick="toggleFeature(subFurn)">FURNITURE</h3>
                    <div class="sub-attribute" id="subFurn"><hr>
                            <span class="spacer">
                                <?php foreach ($furniture as $value) { ?>
                                    <label class="check-align"><input type="checkbox" name="feat[]" value="<?= $value['ITEM_CODE']; ?>" class="chk" onchange="getValues(this.name,'<?=$del;?>')"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
                <span id="convenience" class="attribute"><h3 onclick="toggleFeature(subModern)">CONVENIENCE</h3>
                    <div class="sub-attribute" id="subModern"><hr>
                            <span class="spacer">
                                <?php foreach ($conveniences as $value) { ?>
                                    <label class="check-align"><input type="checkbox" name="feat[]" value="<?= $value['ITEM_CODE']; ?>" class="chk" onchange="getValues(this.name,'<?=$del;?>')"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
                <span id="sundy" class="attribute" ><h3 onclick="toggleFeature(subSundry)">SUNDRY</h3>
                    <div class="sub-attribute" id="subSundry"><hr>
                            <span class="spacer">
                                <?php foreach ($sundry as $value) { ?>
                                    <label class="check-align"><input type="checkbox" name="feat[]" value="<?= $value['ITEM_CODE']; ?>" class="chk" onchange="getValues(this.name,'<?=$del;?>')"/><?= $value['NAME']; ?></label>
                                <?php } ?>
                            </span>
                    </div>
                </span>
            </div>
        </div>
        <span class="error-msg-inline" <?php if (empty($error_message)) {
                                    echo 'style="display:none"';
                                } ?>><?= $error_message; ?></span>
    </div>
</section>
